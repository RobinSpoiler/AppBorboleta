//
//  ChatCell.swift
//  AppiOS
//
//  Created by Jorge Delgado on 14/10/22.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet weak var pfp: UIImageView!
    @IBOutlet weak var sender: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
