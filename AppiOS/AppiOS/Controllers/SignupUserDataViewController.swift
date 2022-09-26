//
//  SignupUserDataViewController.swift
//  AppiOS
//
//  Created by Jorge Delgado on 23/09/22.
//

import UIKit
import DropDown

class SignupUserDataViewController: UIViewController {
    
    let dropdown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dropdown.anchorView = view
        dropdown.dataSource = ["Car", "Motorcycle", "Truck"]
    }

}
