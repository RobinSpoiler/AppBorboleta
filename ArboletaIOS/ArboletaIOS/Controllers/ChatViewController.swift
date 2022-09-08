//
//  ChatViewController.swift
//  ArboletaIOS
//
//  Created by Jorge Delgado on 08/09/22.
//

import UIKit

class ChatViewController: UIViewController {

    @IBOutlet weak var msgImg: UIImageView!
    @IBOutlet weak var convImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        convImg.alpha = 0
        // Do any additional setup after loading the view.
    }
    
    @IBAction func gotoChat(_ sender: Any) {
        print("pressed")
        msgImg.alpha = 0
        convImg.alpha = 1
    }
    
    @IBAction func gotoMessages(_ sender: UIButton) {
        msgImg.alpha = 1
        convImg.alpha = 0
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
