//
//  Recycle.swift
//  Recycle
//
//  Created by Kolbe Surran on 11/10/19.
//  Copyright © 2019 Shockedeel. All rights reserved.
//

import Foundation

class Recycle{
    
    let Recyclable = "We think this is probably recyclable."
    
    let nonRecyclable = "We don't think this is recyclable!"
    
    let plastic = "We think this is plastic! Check the object for the recycling triangle because certain types of plastic are not recyclable!"
    
    let Messages = ["We are very confident in this prediction", "We are feeling pretty good about this prediction","We aren't to sure about this prediction."]
    
    func GetResponse(array: [prediction])->String{
        var responseString = "Something went wront!"
        var message = ""
      let highestProbability = array[0]
        if(highestProbability.probability > 0.50){
            message = Messages[0]
        }
        else if(highestProbability.probability <= 0.50 && highestProbability.probability > 0.35){
            message = Messages[1]
        }
        else {
            message = Messages[2]
        }
       let secondHighestProbability = array[1]
        
        if(highestProbability.tagName == "cardboard"){
            responseString=Recyclable+message
            
        }
        else if(highestProbability.tagName == "ceramic"){
            responseString=nonRecyclable+message
        }
        else if(highestProbability.tagName == "food"){
            responseString=nonRecyclable+message
        }
        else if(highestProbability.tagName == "glass"){
            responseString=Recyclable+message
        }
        else if(highestProbability.tagName == "metalcans"){
            responseString=Recyclable+message
        }
        else if(highestProbability.tagName == "paper"){
            responseString=Recyclable+message
        }
        else if(highestProbability.tagName == "plasticbottle"){
            responseString="We think this is a plastic bottle! Check for the recycling triangle"+message
        }
        else if(highestProbability.tagName == "plasticwrap"){
            responseString=Recyclable+message
        }
        else if(highestProbability.tagName == "styrofoam"){
            responseString=nonRecyclable+message
        }
        else if(highestProbability.tagName == "wood"){
            responseString=Recyclable+message
        }
        else if(highestProbability.tagName == "aluminium"){
            responseString=Recyclable+message
        }
        else if(highestProbability.tagName == "candy"){
            responseString=nonRecyclable+message
        }
        else if(highestProbability.tagName == "light bulb"){
            responseString=nonRecyclable+message
        }
        
        return responseString
       
        
    }
    
    
    
    
   
    
}
    
    
    
struct prediction: Codable{
    var probability: Double
    var tagId: String
    var tagName: String
    
}

struct object: Codable{
    var id: String
    var project: String
    var iteration: String
    var created: String
    var predictions: [prediction]
    
}
struct User: Codable{
       var userId: Int
       var id: Int
       var title: String
       var completed: Bool
}
