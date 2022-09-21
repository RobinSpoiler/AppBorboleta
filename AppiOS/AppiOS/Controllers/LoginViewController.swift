//
//  LoginViewController.swift
//  AppiOS
//
//  Created by Jorge Delgado on 20/09/22.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var EmailInput: UnderlinedTextField!
    @IBOutlet weak var PasswordInput: UnderlinedTextField!
    @IBOutlet weak var LoginButon: UIButton!
    
    @IBOutlet weak var EmailErrorLabel: UILabel!
    @IBOutlet weak var PasswordErrorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LoginButon.tintColor = UIColor(named: "Color1")
        
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        if let email = EmailInput.text, let password = PasswordInput.text {
            Auth.auth().signIn(withEmail: email, password: password) {
                authResult, error in
                if let e = error {
                    self.PasswordErrorLabel.text = e.localizedDescription
                }
                else {
                    print(":)")
                }
            }
        }
    }
}
