//
//  ProfileViewController.swift
//  AppiOS
//
//  Created by Jorge Delgado on 04/10/22.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    @IBOutlet weak var userLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        userLabel.text = Auth.auth().currentUser?.email
        // Do any additional setup after loading the view.
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
