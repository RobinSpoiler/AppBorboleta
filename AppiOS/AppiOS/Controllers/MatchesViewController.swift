//
//  MatchesViewController.swift
//  AppiOS
//
//  Created by Jorge Delgado on 04/10/22.
//

import UIKit
import Firebase
import CenteredCollectionView

class UserCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var testLabel: UILabel!
}

struct User {
    var name: String
    
    init(_ name: String) {
        self.name = name
    }
}

class MatchesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var users = [User]()
    var current = 0
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? UserCollectionViewCell

                // Error checking, if our cell is somehow not able to be cast
                guard let userCell = cell else {
                    print("Unable to instantiate user cell at index \(indexPath.row)")
                    return cell!
                }

                // Give the current cell the corresponding data it needs from our model
                userCell.testLabel.text = users[indexPath.row].name
                print("Current card: \(indexPath.row)")
                return userCell
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let cellPercentWidth: CGFloat = 0.7
    var centeredCollectionViewFlowLayout: CenteredCollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        users.append(User("User1"))
        users.append(User("User2"))
        users.append(User("User3"))
        users.append(User("User4"))
        users.append(User("User5"))
        users.append(User("User6"))
        users.append(User("User7"))
        users.append(User("User8"))
        users.append(User("User9"))
        users.append(User("User10"))
        users.append(User("User11"))
        users.append(User("User12"))
        users.append(User("User13"))
        users.append(User("User14"))
        users.append(User("User15"))
        users.append(User("User16"))
        users.append(User("User17"))
        users.append(User("User18"))
        users.append(User("User19"))

        centeredCollectionViewFlowLayout = collectionView.collectionViewLayout as? CenteredCollectionViewFlowLayout

                // Modify the collectionView's decelerationRate (REQUIRED STEP)
                collectionView.decelerationRate = UIScrollView.DecelerationRate.fast

                // Assign delegate and data source
                collectionView.delegate = self
                collectionView.dataSource = self

                // Configure the required item size (REQUIRED STEP)
                centeredCollectionViewFlowLayout.itemSize = CGSize(
                    width: view.bounds.width * cellPercentWidth,
                    height: view.bounds.height * cellPercentWidth * cellPercentWidth
                )

                // Configure the optional inter item spacing (OPTIONAL STEP)
                centeredCollectionViewFlowLayout.minimumLineSpacing = 20

                // Get rid of scrolling indicators
                collectionView.showsVerticalScrollIndicator = false
                collectionView.showsHorizontalScrollIndicator = true
    }

}
