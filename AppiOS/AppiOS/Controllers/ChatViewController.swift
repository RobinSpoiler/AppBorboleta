//
//  ChatViewController.swift
//  AppiOS
//
//  Created by Jorge Delgado on 16/10/22.
//

import UIKit
import Firebase

class ChatViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BubbleCellID", for: indexPath) as! BubbleCell
        
        let i = indexPath.row
        
        cell.message.text = messages[i].message
        
        return cell
    }
    
    let db = Firestore.firestore()

    @IBOutlet weak var chatImage: UIImageView!
    @IBOutlet weak var chatName: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var messages: [Message] = []
    var chat: Chat? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // barra superior
        chatImage.image = chat?.pfp
        chatImage.layer.cornerRadius = chatImage.frame.height / 2
        chatName.text = chat?.name
        
        tableView.dataSource = self
        tableView.register(
            UINib(nibName: "BubbleCell", bundle: nil),
            forCellReuseIdentifier: "BubbleCellID"
        )
        
        loadMessages()
    }

    func loadMessages() {
        messages = []
        
        let chatDocument = db.collection("chats").document(chat!.chatID)
        
        chatDocument.getDocument { document, error in
            if let e = error {
                print (e)
            }
            else {
                if let document = document, document.exists {
                    let messagesArray = document["messages"] as! [ [String: String] ]
                    
                    for message in messagesArray {
                        self.messages.append(
                            Message(
                                message: message["message"]!,
                                sender: message["sender"]!,
                                timestamp: message["timestamp"]!
                            )
                        )
                        
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
}
