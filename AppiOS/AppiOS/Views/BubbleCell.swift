//
//  BubbleCell.swift
//  AppiOS
//
//  Created by Jorge Delgado on 16/10/22.
//

import UIKit

class BubbleCell: UITableViewCell {

    @IBOutlet weak var bubble: UIView!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var rightPicture: UIImageView!
    @IBOutlet weak var leftPicture: UIImageView!
    @IBOutlet weak var timestamp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bubble.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
