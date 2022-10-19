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
    @IBOutlet weak var pfp: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userLabel.text = Auth.auth().currentUser?.email
        // Do any additional setup after loading the view.
        
        let storageRef = Storage.storage().reference()
        let pfpRef = storageRef.child("profilePics/\(Auth.auth().currentUser!.email!).png")
        
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        pfpRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let e = error {
                self.pfp.image = UIImage(named: "defaultPFP")!
                print(e)
            } else {
                self.pfp.image = UIImage(data: data!)
            }
        }
        
        pfp.layer.cornerRadius = pfp.frame.height / 2
        
    }
    
    @IBAction func logOut(_ sender: UIButton) {
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "toLogin", sender: self)
    }
    
    @IBAction func deleteAccount(_ sender: UIButton) {
        let alert = UIAlertController(
            title: "Deseas eliminar tu cuenta?",
            message: "Esta accion no puede ser revertida",
            preferredStyle: .alert
        )
        
        let cancel = UIAlertAction(title: "Cancelar", style: .destructive)
        let delete = UIAlertAction(title: "Continuar", style: .default) { _ in
            let db = Firestore.firestore()
            let collection = db.collection("users")
            let document = collection.document((Auth.auth().currentUser?.email)!)
            document.delete()
            (Auth.auth().currentUser!).delete()
            try! Auth.auth().signOut()
            self.performSegue(withIdentifier: "toLogin", sender: self)
        }
        alert.addAction(cancel)
        alert.addAction(delete)
        
        present(alert, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
     
     //        let query = db.collection("users").whereField("data.accountType", isEqualTo: "psychologist")
     //        query.getDocuments() {
     //            snap, e in
     //            if let err = e {
     //                print(err)
     //            }
     //            else {
     //                for document in snap!.documents {
     //                    let userID = document.documentID
     //                    //self.users.append(User(userID))
     //                    let storageRef = self.storage.reference()
     //                    let pfpRef = storageRef.child("profilePics/\(userID).png")
     //
     //                    pfpRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
     //                        if let e = error {
     //                            print(e)
     //                        } else {
     //                            let userpfp = UIImage(data: data!)
     //                            self.users.append(User(userID, userpfp!))
     //                        }
     //                    }
     //                    DispatchQueue.main.async {
     //                        self.displayCards()
     //                    }
     //                }
     //            }
     //        }
     

     
     override func viewDidLoad() {
         super.viewDidLoad()

         let myGroup = DispatchGroup()

         for i in 0 ..< 5 {
             myGroup.enter()

             Alamofire.request("https://httpbin.org/get", parameters: ["foo": "bar"]).responseJSON { response in
                 print("Finished request \(i)")
                 myGroup.leave()
             }
         }

         myGroup.notify(queue: .main) {
             print("Finished all requests.")
         }
     }
     
     let query = db.collection("users").whereField("data.accountType", isEqualTo: "psychologist")
     
     query.getDocuments() { qSnapshot, err in
         if let e = err {
             print(e)
         }
         else {
             if let documents = qSnapshot?.documents {
                 for document in documents {
                     
                     let userID = document.documentID
                     
                     self.users.append(User(userID, self.getPFP(userID: userID)))
                     
                     DispatchQueue.main.async {
                         self.displayCards()
                     }
                 }
             }
         }
     }
     
    */

}
