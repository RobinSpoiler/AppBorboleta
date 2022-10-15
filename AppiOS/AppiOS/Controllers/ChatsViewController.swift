//
//  ChatsViewController.swift
//  AppiOS
//
//  Created by Jorge Delgado on 04/10/22.
//

import UIKit
import Foundation
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
                    let name = activeChat["chatName"] as! String
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
                        name: name,
                        message: lastMsg
                    )
                    
                    self.chats.append(currentChat)
                    
                    self.chats.sort {
                        let t1 = $0.message.timestamp
                        let t2 = $1.message.timestamp
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
                        
                        let d1 = dateFormatter.date(from: t1)!
                        let d2 = dateFormatter.date(from: t2)!
                        
                        return d1 > d2
                    }
                    
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
        
        cell.sender.text = chats[i].name
        
        if chats[i].message.sender == Auth.auth().currentUser?.email {
            cell.message.text = "Tu: "
        }
        else {
            cell.message.text = ""
        }
        
        cell.pfp.image = chats[i].pfp
        cell.pfp.layer.cornerRadius = cell.pfp.frame.height / 2
        cell.message.text! += chats[i].message.message
        cell.date.text = chats[i].message.timestamp
        return cell
    }
}
