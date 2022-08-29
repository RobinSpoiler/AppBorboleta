//
//  ViewController.swift
//  ArboletaIOS
//
//  Created by Jorge Delgado on 22/08/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var personCard1: UIImageView!
    @IBOutlet weak var personCard2: UIImageView!
    @IBOutlet weak var personCard3: UIImageView!
    @IBOutlet weak var personCard4: UIImageView!
    @IBOutlet weak var personCard5: UIImageView!
    @IBOutlet weak var personCard6: UIImageView!
    @IBOutlet weak var personCard7: UIImageView!
    @IBOutlet weak var personCard8: UIImageView!
    @IBOutlet weak var personCard9: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let personCards = [
            personCard1,
            personCard2,
            personCard3,
            personCard4,
            personCard5,
            personCard6,
            personCard7,
            personCard8,
            personCard9
        ]
        
        // add rounded corners, and a white border
        for person in personCards {
            person!.layer.cornerRadius = (person?.frame.size.height)! / 10
            person!.layer.borderWidth = (person?.frame.size.height)! / 80
            person!.layer.borderColor = UIColor.white.cgColor
        }
    }
}
