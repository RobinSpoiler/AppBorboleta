//
//  ChatsViewController.swift
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


class ChatsViewController: UIViewController {
    
    @IBOutlet weak var img: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storageRef = Storage.storage().reference()
        let pfpRef = storageRef.child("profilePics/puser1@gmail.com.png")
        
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        pfpRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let e = error {
                print(e)
            } else {
                // Data for "images/island.jpg" is returned
                self.img.image = UIImage(data: data!)
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
