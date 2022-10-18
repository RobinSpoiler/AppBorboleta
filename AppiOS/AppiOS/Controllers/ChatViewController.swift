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
        let message = messages[i]
        
        cell.message.text = message.message
        
        // mensaje de la otra persona
        if message.sender != currentUser!.email! {
            cell.message.textColor = UIColor(named: "BackgroundColor")
            cell.leftPicture.image = self.chat!.pfp
            cell.leftPicture.layer.cornerRadius = cell.leftPicture.frame.height / 2
            cell.bubble.backgroundColor = UIColor(named: "Color2")!
        }
        // mensaje del usuario
        else {
            cell.leftPicture.image = nil
            cell.bubble.backgroundColor = UIColor(named: "Color4")
        }
        
        let timestamp = message.timestamp
        
        let format = "dd-MM-yyyy HH:mm:ss"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format

        let date = dateFormatter.date(from: timestamp)

        if Date().formatted(.dateTime.day().month().year()) == date!.formatted(.dateTime.day().month().year()) {
            let separatedDate = timestamp.components(separatedBy: " ")[1].components(separatedBy: ":")
            cell.timestamp.text = "\(separatedDate[0]):\(separatedDate[1])"
        }
        
        else {
            cell.timestamp.text = timestamp.components(separatedBy: " ")[0]
        }
        
        return cell
    }
    
    let db = Firestore.firestore()

    @IBOutlet weak var chatImage: UIImageView!
    @IBOutlet weak var chatName: UILabel!
    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var messages: [Message] = []
    var chat: Chat? = nil
    var currentUser = Auth.auth().currentUser
    
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

    @IBAction func returnChats(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendMessage(_ sender: UIButton) {
    }
    
    
    
    func loadMessages() {
        
        let chatDocument = db.collection("chats").document(chat!.chatID)
        
        chatDocument.addSnapshotListener { document, error in
            
            self.messages = []
            
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
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        }
    }
}
