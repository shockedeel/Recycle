//
//  prediction_API.swift
//  Recycle
//
//  Created by Kolbe Surran on 11/9/19.
//  Copyright © 2019 Shockedeel. All rights reserved.
//

import Foundation
import UIKit
class PredictionApi{
   var recycle = Recycle()
    
    func makePredictionRequest(image: UIImage)->String{
        var toReturn = [prediction(probability: 0.4, tagId: "", tagName: "")]
        
        
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
        let semaphore = DispatchSemaphore(value: 0)
       let task = URLSession.shared.dataTask(with: request) { data, response, error in
           guard let data = data,
               let response = response as? HTTPURLResponse,
               error == nil else {                                              // check for fundamental networking error
               print("error", error ?? "Unknown error")
               return
           }
        semaphore.signal()
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
        sleep(5)
            
            responseString = String(data: data, encoding: .utf8) ?? ""
            
        
           dataToReturn = data
       }
        
       task.resume()
    semaphore.wait()
        
        return stringReturn
    }
    
    
}
