//
//  PasswordVisibility.swift
//  AppiOS
//
//  Created by Jorge Delgado on 21/09/22.
//

import UIKit
import Foundation

struct PasswordVisibility {
    func Switch(VisibilityButton button : UIButton, PasswordField field : UITextField) {
        
        if button.currentImage == UIImage(systemName: "eye") {
            button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            field.isSecureTextEntry = false
        }
        else {
            button.setImage(UIImage(systemName: "eye"), for: .normal)
            field.isSecureTextEntry = true
        }
    }
}
