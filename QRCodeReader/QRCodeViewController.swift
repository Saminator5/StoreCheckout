//
//  QRCodeViewController.swift
//  QRCodeReader
//
//  Created by Samuel Lefcourt on 1/31/2019
//

import UIKit

class QRCodeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.setGradientBackground(colorOne: Colors.lightGrey, colorTwo: Colors.green)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    @IBAction func unwindToHomeScreen(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }

}
