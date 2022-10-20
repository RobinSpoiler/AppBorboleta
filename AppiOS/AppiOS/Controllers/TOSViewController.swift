//
//  TOSViewController.swift
//  AppiOS
//
//  Created by Jorge Delgado on 03/10/22.
//

import UIKit
import Firebase

class TOSViewController: UIViewController {

    @IBOutlet weak var DeclineBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DeclineBtn.layer.borderColor = UIColor(named: "Color3")?.cgColor
        DeclineBtn.layer.borderWidth = 1.2
        DeclineBtn.layer.cornerRadius = 7
    }
    
    @IBAction func AcceptButton(_ sender: UIButton) {
        
    }
    

    @IBAction func DeclineButton(_ sender: UIButton) {
        // Elimina cuenta del usuario
        
        let db = Firestore.firestore()
        let collection = db.collection("users")
        let document = collection.document((Auth.auth().currentUser?.email)!)
        document.delete()
        (Auth.auth().currentUser!).delete()
        
        performSegue(withIdentifier: "toLogin", sender: self)
    }
}
