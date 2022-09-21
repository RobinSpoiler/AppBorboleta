//
//  LoginViewController.swift
//  AppiOS
//
//  Created by Jorge Delgado on 20/09/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var EmailInput: UnderlinedTextField!
    @IBOutlet weak var PasswordInput: UnderlinedTextField!
    @IBOutlet weak var LoginButon: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LoginButon.tintColor = UIColor(named: "Color1")
        // Do any additional setup after loading the view.
    }
    
}
