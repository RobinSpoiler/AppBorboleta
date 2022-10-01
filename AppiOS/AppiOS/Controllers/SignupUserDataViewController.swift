//
//  SignupUserDataViewController.swift
//  AppiOS
//
//  Created by Jorge Delgado on 23/09/22.
//

import UIKit
import iOSDropDown
import Firebase

class SignupUserDataViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var PhoneField: UITextField!
    @IBOutlet weak var BirthdayPicker: UIDatePicker!
    @IBOutlet weak var pronounsDropdown: DropDown!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PhoneField.keyboardType = UIKeyboardType.numberPad
        
        let pronouns = ["ella", "el", "elle"]

        pronounsDropdown.optionArray = pronouns
    }

    @IBAction func NextButton(_ sender: UIButton) {
        let phoneNumber = PhoneField.text
        let pronouns = pronounsDropdown.text
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
        let birthday = dateFormatter.string(from: BirthdayPicker.date)
        
        let collection = db.collection("users")
        let document = collection.document((Auth.auth().currentUser?.email)!)
        
        document.updateData([
            "data.birthday" : birthday,
            "data.phone" : phoneNumber!,
            "data.pronouns" : pronouns!
        ])
    }
}
