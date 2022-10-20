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
import iOSDropDown

class ProfileViewController: UIViewController {

    @IBOutlet weak var accType: UILabel!
    @IBOutlet weak var pfp: UIImageView!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var editInfo: UIButton!
    @IBOutlet weak var deleteAcc: UIButton!
    @IBOutlet weak var pronounsDD: DropDown!
    
    var editingEnabled = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let storageRef = Storage.storage().reference()
        let docRef = Firestore.firestore().collection("users").document(Auth.auth().currentUser!.email!)
        let pfpRef = storageRef.child("profilePics/\(Auth.auth().currentUser!.email!).png")
        
        self.phoneNumber.borderStyle = .none
        self.nameField.borderStyle = .none
        self.pronounsDD.borderStyle = .none
        
        editInfo.layer.cornerRadius = 12
        deleteAcc.layer.cornerRadius = 12
        
        pronounsDD.optionArray = ["ella", "el", "elle"]
        
        phoneNumber.keyboardType = UIKeyboardType.numberPad
        
        self.nameField.isUserInteractionEnabled = false
        self.phoneNumber.isUserInteractionEnabled = false
        self.pronounsDD.isUserInteractionEnabled = false
        
        docRef.getDocument { document, error in
            if let e = error {
                print(e)
            }
            else {
                if let document = document, document.exists {
                    let userData = document["data"] as! [String: Any]
                    let userName = userData["name"] as! String
                    let accountType = userData["accountType"] as! String
                    let phoneNum = userData["phone"] as! String
                    
                    self.accType.text = accountType
                    self.phoneNumber.text = phoneNum
                    self.nameField.text = userName
                }
            }
        }
        
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
    
    @IBAction func editProfileInfo(_ sender: UIButton) {
        // cambiar a modo de vista
        if editingEnabled {
            self.editInfo.setTitle("Editar informacion", for: .normal)
            self.editingEnabled = false
            
            self.nameField.isUserInteractionEnabled = false
            self.phoneNumber.isUserInteractionEnabled = false
            self.pronounsDD.isUserInteractionEnabled = false
            
            self.phoneNumber.borderStyle = .none
            self.nameField.borderStyle = .none
            self.pronounsDD.borderStyle = .none
            
            let docRef = Firestore.firestore().collection("users").document(Auth.auth().currentUser!.email!)
            
            docRef.updateData([
                "data.name": nameField.text!,
                "data.phone" : phoneNumber.text!,
                "data.pronouns" : pronounsDD.text!
            ])
        }
        // cambiar a modo de edicion
        else {
            self.editInfo.setTitle("Guardar cambios", for: .normal)
            self.editingEnabled = true
            
            self.nameField.isUserInteractionEnabled = true
            self.phoneNumber.isUserInteractionEnabled = true
            self.pronounsDD.isUserInteractionEnabled = true
            
            self.phoneNumber.borderStyle = .roundedRect
            self.nameField.borderStyle = .roundedRect
            self.pronounsDD.borderStyle = .roundedRect
        }
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
