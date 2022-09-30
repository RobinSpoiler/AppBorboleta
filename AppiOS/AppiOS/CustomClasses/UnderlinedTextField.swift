//
//  UnderlinedTextField.swift
//  AppiOS
//
//  Created by Jorge Delgado on 20/09/22.
//

import UIKit
import iOSDropDown

class UnderlinedTextField: UITextField {
    required init?(coder : NSCoder) {
        super.init(coder: coder)
        
        setUpUnderlinedTextField()
    }
    
    func setUpUnderlinedTextField() {
        let bottomLayer = CALayer()
        bottomLayer.frame = CGRect(x: 0, y: self.frame.height, width: self.frame.width - 40, height: 1)
        bottomLayer.backgroundColor = UIColor(named: "Color3")?.cgColor
        self.layer.addSublayer(bottomLayer)
    }
}
