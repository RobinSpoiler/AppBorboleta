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
        let cell = tableView.dequeueReusableCell(withIdentifier: "bubbleCell", for: indexPath)
        let i = indexPath.row
        
        cell.textLabel?.text = messages[i].message
        
        return cell
    }
    

    @IBOutlet weak var chatImage: UIImageView!
    @IBOutlet weak var chatName: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var messages: [Message] = [
        Message(message: "howdy", sender: "u1", timestamp: "123"),
        Message(message: "hello", sender: "u1", timestamp: "123"),
    ]
    var chat: Chat? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatImage.image = chat?.pfp
        chatImage.layer.cornerRadius = chatImage.frame.height / 2
        chatName.text = chat?.name
        
        tableView.dataSource = self
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
