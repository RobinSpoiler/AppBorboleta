//
//  SignupPreferencesViewController.swift
//  AppiOS
//
//  Created by Jorge Delgado on 01/10/22.
//

import UIKit
import Firebase

class SignupPreferencesViewController: UIViewController {

    let db = Firestore.firestore()
    
    var Q1Selected: Int? = nil
    var Q2Selected: Int? = nil
    var Q3Selected: Int? = nil
    var Q4Selected: Int? = nil
    var Q5Selected: Set<Int>? = nil
    var Q6Selected: Int? = nil
    
    @IBOutlet var Q1Options: [UIButton]!
    @IBOutlet var Q2Options: [UIButton]!
    @IBOutlet var Q3Options: [UIButton]!
    @IBOutlet var Q4Options: [UIButton]!
    @IBOutlet var Q5Options: [UIButton]!
    @IBOutlet var Q6Options: [UIButton]!
    
    @IBOutlet weak var SelectionError: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func Q1OptionSelected(_ sender: UIButton) {
        Q1Selected = AppiOS.OptionSelected().Single(sender, Q1Options)
    }
    
    @IBAction func Q2OptionSelected(_ sender: UIButton) {
        Q2Selected = AppiOS.OptionSelected().Single(sender, Q2Options)
    }
    
    @IBAction func Q3OptionSelected(_ sender: UIButton) {
        Q3Selected = AppiOS.OptionSelected().Single(sender, Q3Options)
    }
    
    @IBAction func Q4OptionSelected(_ sender: UIButton) {
        Q4Selected = AppiOS.OptionSelected().Single(sender, Q4Options)
    }
    
    @IBAction func Q5OptionSelected(_ sender: UIButton) {
        Q5Selected = AppiOS.OptionSelected().Multiple(sender, Q5Options)
    }
    
    @IBAction func Q6OptionSelected(_ sender: UIButton) {
        Q6Selected = AppiOS.OptionSelected().Single(sender, Q6Options)
    }
    
    @IBAction func NextButton(_ sender: UIButton) {
        let allOptions = [
            Q1Options,
            Q2Options,
            Q3Options,
            Q4Options,
            Q5Options,
            Q6Options
        ]
        // verificar que todos los campos hayan sido seleccionados
        if AppiOS.Checkboxes().checked(allOptions) {
            
            let collection = db.collection("users")
            let document = collection.document((Auth.auth().currentUser?.email)!)
            
            // primero se agregan los atributos que son de valor int, ya que los mapas en Swift solo permiten un tipo de dato como valor en mapas
            document.updateData([
                "preferences" : [
                    "q1" : Q1Selected,
                    "q2" : Q2Selected,
                    "q3" : Q3Selected,
                    "q4" : Q4Selected,
                    "q6" : Q1Selected
                ]
            ])
            
            // posteriormente se agrega el array de forma ordenada ascendiente
            document.updateData([
                "preferences.q5" : Array(Q5Selected!).sorted()
            ])
        }
        else {
            SelectionError.text = "Porfavor, llena todos los campos"
        }
    }
}
