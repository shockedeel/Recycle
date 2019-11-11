//
//  prettyButton.swift
//  Recycle
//
//  Created by Kolbe Surran on 11/10/19.
//  Copyright © 2019 Shockedeel. All rights reserved.
//

import Foundation
import UIKit

class cusButton: UIButton{
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupButton()
    }
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
        setupButton()
    }
   
    private func setupButton(){
        
        
        self.layer.cornerRadius=25
        self.layer.borderWidth=1
        
        
    }
    
}

