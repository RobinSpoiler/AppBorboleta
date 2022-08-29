//
//  File.swift
//  ArboletaIOS
//
//  Created by Jorge Delgado on 28/08/22.
//

import UIKit

struct PersonCard {
    func AddRoundBorder(cards : [UIImageView?]) {
        for card in cards {
            card!.layer.cornerRadius = (card?.frame.size.height)! / 10
            card!.layer.borderWidth = (card?.frame.size.height)! / 80
            card!.layer.borderColor = UIColor.white.cgColor
        }
    }
}
