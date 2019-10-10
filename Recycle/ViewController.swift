//
//  ViewController.swift
//  Recycle
//
//  Created by Kolbe Surran on 10/2/19.
//  Copyright © 2019 Shockedeel. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet var mainUI: UIView!
    
    @IBAction func takePhotoButton(_ sender: Any) {
       let imagePickerController=UIImagePickerController()
       imagePickerController.delegate=self
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
        }
        else{
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
            print("unable to reach camera")
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

