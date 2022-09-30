//
//  SignupViewController.swift
//  AppiOS
//
//  Created by Jorge Delgado on 21/09/22.
//

import UIKit
import SwiftUI
import Firebase

class SignupViewController: UIViewController {
    
    @IBOutlet weak var NameField: UITextField!
    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var PasswordField: UITextField!
    @IBOutlet weak var ConfirmField: UITextField!
    
    @IBOutlet weak var PasswordVisibility: UIButton!
    @IBOutlet weak var ConfirmVisibility: UIButton!
    
    
    @IBOutlet weak var NameError: UILabel!
    @IBOutlet weak var EmailError: UILabel!
    @IBOutlet weak var PasswordError: UILabel!
    @IBOutlet weak var ConfirmError: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func PasswordVisibilityButton(_ sender: UIButton) {
        AppiOS.PasswordVisibility().Switch(VisibilityButton: PasswordVisibility, PasswordField: PasswordField)
    }
    
    @IBAction func ConfirmVisibilityButton(_ sender: UIButton) {
        AppiOS.PasswordVisibility().Switch(VisibilityButton: ConfirmVisibility, PasswordField: ConfirmField)
    }
    
    @IBAction func NextButton(_ sender: UIButton) {
        if let email = EmailField.text, let password = PasswordField.text {
            Auth.auth().createUser(withEmail: email, password: password){
                authResult, error in
                if let e = error {
                    self.ConfirmError.text = e.localizedDescription
                } else {
                    self.performSegue(withIdentifier: "toUserData", sender: self)
                }
            }
        }
    }
}
