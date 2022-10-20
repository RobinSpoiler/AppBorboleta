//
//  HomeViewController.swift
//  AppiOS
//
//  Created by Jorge Delgado on 04/10/22.
//

import UIKit

class HomeViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func goToWebsite(_ sender: UIButton) {
        if let url = URL(string: "https://linktr.ee/borboletamx") {
            UIApplication.shared.open(url)
        }
    }
    @IBAction func goTopPodcast(_ sender: UIButton) {
        if let url = URL(string: "https://open.spotify.com/show/0MAY6vcrhDT46Czrs3ZLus?si=88fe1c636f164eea") {
            UIApplication.shared.open(url)
        }
    }
    
}
