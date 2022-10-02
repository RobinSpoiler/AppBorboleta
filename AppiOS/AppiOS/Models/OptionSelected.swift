//
//  OptionSelectedSingle.swift
//  AppiOS
//
//  Created by Jorge Delgado on 02/10/22.
//

import UIKit
import Foundation

struct OptionSelected {
    func Single(_ sender: UIButton, _ Options: [UIButton]!) -> Int{
        let selectedImg = UIImage(systemName: "checkmark.square.fill")
        let unselectedImg = UIImage(systemName: "square")
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
        print(selected!)
        return selected!
    }
    
}
