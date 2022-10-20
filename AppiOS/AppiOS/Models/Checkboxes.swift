//
//  AllCheckboxes.swift
//  AppiOS
//
//  Created by Jorge Delgado on 03/10/22.
//

import UIKit
import Foundation

struct Checkboxes {
    
    let selectedImg = UIImage(systemName: "checkmark.square.fill")
    
    func checked(_ allOptions: [[UIButton]?]) -> Bool{
        
        var thereIsSelectedOption = false
        
        for options in allOptions {

            thereIsSelectedOption = false
            
            for option in options! {
                if option.currentImage == selectedImg {
                    thereIsSelectedOption = true
                }
            }
            
            if !thereIsSelectedOption {
                return false
            }
        }
        
        return true
    }
}
