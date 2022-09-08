//
//  MatchesViewController.swift
//  ArboletaIOS
//
//  Created by Jorge Delgado on 08/09/22.
//

import UIKit

class MatchesViewController: UIViewController {

    var currentView : String?
    
    
    @IBOutlet weak var btn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(currentView == nil) {
            
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextButton(_ sender: UIButton) {
        performSegue(withIdentifier: "completedProfile", sender: self)
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
