//
//  ProfileViewController.swift
//  AppiOS
//
//  Created by Jorge Delgado on 04/10/22.
//

import UIKit
import Firebase
import CenteredCollectionView
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage
import SDWebImage

class ProfileViewController: UIViewController {

    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var tview: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userLabel.text = Auth.auth().currentUser?.email
        // Do any additional setup after loading the view.
        
        let storageRef = Storage.storage().reference()
        let pfpRef = storageRef.child("profilePics/puser1@gmail.com.png")
        
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        pfpRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let e = error {
                print(e)
            } else {
                self.tview.backgroundColor = UIColor(patternImage: UIImage(data: data!)!)
                let gradient = CAGradientLayer()
                gradient.frame = self.tview.bounds
                let startColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
                let endColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7).cgColor
                gradient.colors = [startColor, endColor]
                self.tview.layer.insertSublayer(gradient, at: 1)
            }
        }
        
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
