//
//  ProfileViewController.swift
//  ArboletaIOS
//
//  Created by Jorge Delgado on 08/09/22.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var card: UIView!
    @IBOutlet weak var pfp: UIImageView!
    @IBOutlet weak var sqr: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        card.layer.cornerRadius = 10
        pfp.layer.cornerRadius = 128 / 2
        sqr.layer.cornerRadius = 15
        // Do any additional setup after loading the view.
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
