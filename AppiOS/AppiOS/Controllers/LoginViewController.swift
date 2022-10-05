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
        
        // verificar si el usuario ya ha iniciado sesion antes
        // en caso de que si, realiza segue a home
        
        // DESCOMENTAR PARA FINAL
        
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "toHome", sender: self)
        }
        
        LoginButton.tintColor = UIColor(named: "Color1")
    }
    
    // alternar la visibilidad del campo de la contrasena
    @IBAction func PasswordVisibilityButton(_ sender: UIButton) {
        AppiOS.PasswordVisibility().Switch(VisibilityButton: PasswordVisibility, PasswordField: PasswordInput)
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        if let email = EmailInput.text, let password = PasswordInput.text {
            Auth.auth().signIn(withEmail: email, password: password) {
                authResult, error in
                if let e = error {
                    // codigo en caso de que el login sea fallido
                    // TODO
                    //   * Asignar el error a su label correspondiente
                    self.PasswordErrorLabel.text = e.localizedDescription
                }
                else {
                    // login exitoso, segue a home
                    self.performSegue(withIdentifier: "toHome", sender: self)
                }
            }
        }
    }
}
