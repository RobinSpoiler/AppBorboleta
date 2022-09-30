//
//  LoginViewController.swift
//  AppiOS
//
//  Created by Jorge Delgado on 20/09/22.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var EmailInput: UITextField!
    @IBOutlet weak var PasswordInput: UITextField!
    @IBOutlet weak var LoginButton: UIButton!
    
    @IBOutlet weak var EmailErrorLabel: UILabel!
    @IBOutlet weak var PasswordErrorLabel: UILabel!
    
    @IBOutlet weak var PasswordVisibility: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LoginButton.tintColor = UIColor(named: "Color1")
    }
    
    @IBAction func PasswordVisibilityButton(_ sender: UIButton) {
        AppiOS.PasswordVisibility().Switch(VisibilityButton: PasswordVisibility, PasswordField: PasswordInput)
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        if let email = EmailInput.text, let password = PasswordInput.text {
            Auth.auth().signIn(withEmail: email, password: password) {
                authResult, error in
                if let e = error {
                    self.PasswordErrorLabel.text = e.localizedDescription
                }
                else {
                    self.performSegue(withIdentifier: "toHome", sender: self)
                }
            }
        }
    }
}
