//
//  SignupPreferencesViewController.swift
//  AppiOS
//
//  Created by Jorge Delgado on 01/10/22.
//

import UIKit

class SignupPreferencesViewController: UIViewController {

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
}
