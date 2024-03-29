//
//  ViewController.swift
//  Recycle
//
//  Created by Kolbe Surran on 10/2/19.
//  Copyright © 2019 Shockedeel. All rights reserved.
//

import UIKit
import AVFoundation
import Vision
class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    var responseMessage: String = ""
    @IBOutlet weak var outputTextLabel: UILabel!
    @IBOutlet var mainUI: UIView!
    var api = PredictionApi()
    var recycle = Recycle()
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
        let viewNext = SecondViewController();
        
        self.present(viewNext, animated: true, completion: nil)
        
    }
    internal func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
            else {
            return
        }
       
            responseMessage = makePredictionRequest(image: image)
            outputTextLabel.text=responseMessage
        
        
        
        
       
        
    }
    
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func makePredictionRequest(image: UIImage)->String{
        var toReturn = [prediction(probability: 0.4, tagId: "", tagName: "")]
        
        let semaphore =  DispatchSemaphore(value: 0)
        var responseString = ""
        var dataToReturn: Data
        dataToReturn = "".data(using: .utf8)!
        let imageData = UIImageJPEGRepresentation(image, 0.5)
        var request = URLRequest(url: URL(string: "https://recyclecustomvision.cognitiveservices.azure.com/customvision/v3.0/Prediction/10a34aea-86c4-480c-9755-0e6f46667fea/classify/iterations/Iteration1/image")! as URL)
        request.httpMethod="POST"
        request.addValue("d877d6ff68b947e88deb0cdeb09b309e",forHTTPHeaderField: "Prediction-Key")
        request.addValue("application/octet-stream",forHTTPHeaderField: "Content-Type")
        request.httpBody=imageData
        
        var stringReturn = ""
        
       let task = URLSession.shared.dataTask(with: request) { data, response, error in
           guard let data = data,
               let response = response as? HTTPURLResponse,
               error == nil else {                                              // check for fundamental networking error
               print("error", error ?? "Unknown error")
               return
           }
        
            do {
                //here dataResponse received from a network request
                let decoder = JSONDecoder()
                //Decode JSON Response Data
                let model = try decoder.decode(object.self,
                                               from: data)
                print(model.predictions[0].tagName)
                print(model.predictions[0].probability)
              toReturn =  model.predictions//Output - 1221
                 stringReturn = self.recycle.GetResponse(array: toReturn)
                
                
            } catch let parsingError {
                print("Error", parsingError)
            }
            

           guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
               print("statusCode should be 2xx, but is \(response.statusCode)")
               print("response = \(response)")
               return
           }
        
            
            responseString = String(data: data, encoding: .utf8) ?? ""
            
        
           dataToReturn = data
       }
        task.resume()
        
       
    
        
        return stringReturn
    }
    

}

