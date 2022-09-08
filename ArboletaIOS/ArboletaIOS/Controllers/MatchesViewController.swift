//
//  MatchesViewController.swift
//  ArboletaIOS
//
//  Created by Jorge Delgado on 08/09/22.
//

import UIKit

class MatchesViewController: UIViewController {
    
    @IBOutlet weak var imgCards: UIImageView!
    @IBOutlet weak var indiapp: UIImageView!
    @IBOutlet weak var prompt: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        indiapp.alpha = 0
        imgCards.alpha = 1
        prompt.alpha = 0
        // Do any additional setup after loading the view.
    }
    
    @IBAction func gotoNext(_ sender: UIButton) {
        indiapp.alpha = 1
        imgCards.alpha = 0
    }
    
     @IBAction func createapp(_ sender: UIButton) {
         indiapp.alpha = 0.5
         prompt.alpha = 1
         prompt.layer.cornerRadius = 25
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
