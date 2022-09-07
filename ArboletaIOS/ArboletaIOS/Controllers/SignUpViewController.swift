//
//  SignUpViewController.swift
//  ArboletaIOS
//
//  Created by Jorge Delgado on 28/08/22.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        signUpButton.tintColor = UIColor.systemGray6
    }
    
    @IBAction func logInButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "signUpToLogIn", sender: self)
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
