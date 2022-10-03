//
//  OptionSelectedSingle.swift
//  AppiOS
//
//  Created by Jorge Delgado on 02/10/22.
//

import UIKit
import Foundation

struct OptionSelected {
    
    let selectedImg = UIImage(systemName: "checkmark.square.fill")
    let unselectedImg = UIImage(systemName: "square")
    
    func Single(_ sender: UIButton, _ Options: [UIButton]!) -> Int{
        var selected: Int? = nil
        
        for option in Options {
            if sender.tag == option.tag {
                option.setImage(selectedImg, for: .normal)
                selected = sender.tag
            }
            else {
                option.setImage(unselectedImg, for: .normal)
            }
        }
        
        return selected!
    }
    
    func Switch(_ Button: UIButton) {
        Button.setImage(
            Button.currentImage == selectedImg ?
            unselectedImg : selectedImg,
            for: .normal)
    }
    
    func Multiple(_ sender: UIButton, _ Options: [UIButton]!) -> Set<Int>{
        self.Switch(sender)
        
        var selectedOptions = Set<Int>()
        
        for option in Options {
            if option.currentImage == selectedImg {
                selectedOptions.insert(option.tag)
            }
        }
        
        
        return selectedOptions
    }
    
}
