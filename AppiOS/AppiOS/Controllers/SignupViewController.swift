//
//  SignupViewController.swift
//  AppiOS
//
//  Created by Jorge Delgado on 21/09/22.
//

import UIKit

class SignupViewController: UIViewController {
    
    @IBOutlet weak var NextButton: UIButton! {
        didSet {
            NextButton.layer.cornerRadius = NextButton.frame.height / 2
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}
