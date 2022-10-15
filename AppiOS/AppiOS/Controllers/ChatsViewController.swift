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
    
    let db = Firestore.firestore()
    let currentUser = Auth.auth().currentUser!
    
    @IBOutlet weak var tableView: UITableView!
    
    var chats: [Chat] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.register(
            UINib(nibName: "ChatCell", bundle: nil),
            forCellReuseIdentifier: "ReusableChatCell"
        )
        
        loadChats()
    }
    
    func loadChats() {
        chats = []
        let userDocRef = db.collection("users").document(currentUser.email!)
        
        userDocRef.getDocument { document, error in
            if let document = document, document.exists {
                let activeChats = document["activeChats"] as! [ [String : Any] ]
                
                for activeChat in activeChats {
                    let chatID = activeChat["chatID"] as! String
                    let with = activeChat["with"] as! String
                    let lastMessage = activeChat["lastMessage"] as! [String : String]
                    
                    let message = lastMessage["message"]!
                    let sender = lastMessage["sender"]!
                    let timestamp = lastMessage["time"]!
                    
                    let lastMsg = Message(
                        message: message,
                        sender: sender,
                        timestamp: timestamp
                    )
                    
                    let currentChat = Chat(
                        chatID: chatID,
                        pfp: UIImage(named: "defaultPFP")!,
                        with: with,
                        message: lastMsg
                    )
                    
                    self.chats.append(currentChat)
                    
                    self.tableView.reloadData()
                }
            }
        }
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
        
        cell.sender.text = chats[i].with
        
        if chats[i].message.sender == Auth.auth().currentUser?.email {
            cell.message.text = "Tu"
        }
        else {
            cell.message.text = chats[i].message.sender
        }
        
        cell.message.text! += ": \(chats[i].message.message)"
        cell.date.text = chats[i].message.timestamp
        return cell
    }
}
