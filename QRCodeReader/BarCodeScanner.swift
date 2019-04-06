//
//  BarCodeScanner.swift
//  QRCodeReader
//
//  Created by Samuel Lefcourt on 2/12/19.
//  Copyright © 2019 AppCoda. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    var productInfo: String!
    
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
            found(code: stringValue)
            performSegue(withIdentifier: "info", sender: self)

        }
        
        dismiss(animated: true)
    }
    
    
    func found(code: String) {
        print(code)
        // api call
        let key = "2u1hergdpk4zr3bpk4rwdpc7gnindc"
        //let url = URL(string:"https://api.barcodelookup.com/v2/products?barcode=\(code)&key=\(key)")!
        let url = URL(string:"https://jsonplaceholder.typicode.com/todos/1")!

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if(error == nil) {
                let returnedData = data!
                print("returnedData: ", returnedData)

                if let data = data, let stringResponse = String(data: data, encoding: .utf8) {
                    print("Response \(stringResponse)")
                    self.productInfo = stringResponse
                    
                    //UIApplication.topViewController()?.present(ItemViewController(), animated: true, completion: nil)
                 
                }
            }
            else {
                print(error)
            }
        }

        task.resume()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      var vc = segue.destination as! ItemViewController
      vc.productInfo = self.productInfo
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
