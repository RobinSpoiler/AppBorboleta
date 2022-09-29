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
    @IBOutlet weak var pronounsDropdown: DropDown!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PhoneField.keyboardType = UIKeyboardType.numberPad
    }

}
