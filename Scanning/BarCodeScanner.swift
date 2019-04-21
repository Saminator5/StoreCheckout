import Foundation
import AVFoundation
import UIKit

class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!

    var productInfo: String!
    var data: Data? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }

        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }

        let metadataOutput = AVCaptureMetadataOutput()

        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)

            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.ean8, .ean13, .pdf417]
        } else {
            failed()
            return
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)

        captureSession.startRunning()
    }

    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()

        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))

            let group = DispatchGroup()
            group.enter()

            DispatchQueue.global().async {
                self.found(code: stringValue)
                group.leave()
            }

            group.wait()

            print("barcode data: ", self.data)
            while(self.data == nil) {}
            performSegue(withIdentifier: "info", sender: self)

        }
    }


    func found(code: String) {
        print(code)


        if (captureSession?.isRunning == true) {
            print("running")
            captureSession.stopRunning()
        }

        // api call
        let key = "efa3lcqujtqpqs9jjwvlzmvjhkaxul"
        let url = URL(string:"https://api.barcodelookup.com/v2/products?barcode=\(code)&key=\(key)")!
        //let url = URL(string:"https://jsonplaceholder.typicode.com/todos/1")!

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if(error == nil) {
                if let data = data, let stringResponse = String(data: data, encoding: .utf8) {
                    self.data = data
                    print("set self.data ", self.data)
                    self.productInfo = stringResponse
                    print("Response: ", self.productInfo)
                }
            }
            else {
                print(error ?? "error")
            }
        }

        task.resume()
        //.performSegue(withIdentifier: "info", sender: self)

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ItemViewController
        vc.data = self.data
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}


