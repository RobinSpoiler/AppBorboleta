//
//  MatchesViewController.swift
//  AppiOS
//
//  Created by Jorge Delgado on 04/10/22.
//

import UIKit
import Firebase

class MatchesViewController: UIViewController {

    @IBOutlet weak var tstlabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getAllPsychologist()
        
        print(1)
    }
    
    func getAllPsychologist() {
        let db = Firestore.firestore()
        
        let collection = db.collection("users")
        
        let query = collection.whereField("data.accountType", isEqualTo: "psychologist")
        
        query.getDocuments() {querySnapshot, err in
            
            if let e = err {
                print(e)
            }
            else {
                for document in querySnapshot!.documents {
                    self.tstlabel.text = document.documentID
                }
            }
        }
    }

}
