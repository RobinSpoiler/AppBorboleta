//
//  ChatsViewController.swift
//  AppiOS
//
//  Created by Jorge Delgado on 04/10/22.
//

import UIKit
import Firebase
import CenteredCollectionView
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage


class ChatsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var chats: [String] = [
        "Samuel",
        "McLovin",
        "Kim"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.register(
            UINib(nibName: "ChatCell", bundle: nil),
            forCellReuseIdentifier: "ReusableChatCell"
        )
        
        
    }
}

extension ChatsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "ReusableChatCell",
            for: indexPath
        ) as! ChatCell
        
        let i = indexPath.row
        
        cell.sender.text = chats[i]
        
        return cell
    }
    
    
}
