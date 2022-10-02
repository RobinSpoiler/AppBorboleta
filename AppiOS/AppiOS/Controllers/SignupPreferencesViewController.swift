//
//  SignupPreferencesViewController.swift
//  AppiOS
//
//  Created by Jorge Delgado on 01/10/22.
//

import UIKit

class SignupPreferencesViewController: UIViewController {

    @IBOutlet var Q1Options: [UIButton]!
    var Q1Selected: Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func Q1OptionSelected(_ sender: UIButton) {
        let selectedImg = UIImage(systemName: "checkmark.square.fill")
        let unselectedImg = UIImage(systemName: "square")
        
        for option in Q1Options {
            if sender.tag == option.tag {
                option.setImage(selectedImg, for: .normal)
                Q1Selected = sender.tag
            }
            else {
                option.setImage(unselectedImg, for: .normal)
            }
        }
    }
    
}
