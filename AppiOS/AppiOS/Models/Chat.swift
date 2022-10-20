//
//  Chat.swift
//  AppiOS
//
//  Created by Jorge Delgado on 14/10/22.
//

import Foundation
import UIKit

struct Chat {
    var chatID: String
    var pfp: UIImage
    var with: String
    var name: String
    var message: Message
    
    init(chatID: String, pfp: UIImage, with: String, name: String, message: Message) {
        self.chatID = chatID
        self.pfp = pfp
        self.with = with
        self.name = name
        self.message = message
    }
}
