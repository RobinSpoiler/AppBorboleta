//
//  SignupUserDataViewController.swift
//  AppiOS
//
//  Created by Jorge Delgado on 23/09/22.
//

import UIKit
import iOSDropDown

class SignupUserDataViewController: UIViewController {
    
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
        let date = dateFormatter.string(from: BirthdayPicker.date)
        
        
    }
}
