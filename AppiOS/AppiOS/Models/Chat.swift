//
//  Chat.swift
//  AppiOS
//
//  Created by Jorge Delgado on 14/10/22.
//

import Foundation
import UIKit

struct Chat {
    var pfp: UIImage
    var sender: String
    var message: String
    var time: String
    
    init(pfp: UIImage, sender: String, message: String, time: String) {
        self.pfp = pfp
        self.sender = sender
        self.message = message
        self.time = time
    }
}
