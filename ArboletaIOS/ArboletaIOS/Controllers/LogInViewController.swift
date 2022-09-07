//
//  LogInViewController.swift
//  ArboletaIOS
//
//  Created by Jorge Delgado on 28/08/22.
//

import UIKit

class LogInViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.tintColor = UIColor.systemGray6
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        self.performSegue(withIdentifier: "logInToSignUp", sender: self)
    }
    
    @IBAction func goToFeed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "logInToFeed", sender: self)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
