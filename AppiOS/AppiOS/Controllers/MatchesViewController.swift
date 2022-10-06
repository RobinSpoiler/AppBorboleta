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
    
    var users: [User] = []
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
        return userCell
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let cellPercentWidth: CGFloat = 0.7
    var centeredCollectionViewFlowLayout: CenteredCollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    

        let group = DispatchGroup()
        group.enter()
        
        DispatchQueue.global(qos: .default).async {
            let db = Firestore.firestore()
            let usersCollection = db.collection("users")
            let query = usersCollection.whereField("data.accountType", isEqualTo: "psychologist")
            
            let documents = query.getDocuments(){ snapshot, err in
                if let e = err {
                    print(e)
                }
                else {
                    for document in snapshot!.documents {
                        print(document.documentID)
                        self.users.append(User(document.documentID))
                    }
                    self.centeredCollectionViewFlowLayout = self.collectionView.collectionViewLayout as? CenteredCollectionViewFlowLayout
                    
                    // Modify the collectionView's decelerationRate (REQUIRED STEP)
                    self.collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
                    
                    // Assign delegate and data source
                    self.collectionView.delegate = self
                    self.collectionView.dataSource = self
                    
                    // Configure the required item size (REQUIRED STEP)
                    self.centeredCollectionViewFlowLayout.itemSize = CGSize(
                        width: self.view.bounds.width * self.cellPercentWidth,
                        height: self.view.bounds.height * self.cellPercentWidth * self.cellPercentWidth
                    )
                    
                    // Configure the optional inter item spacing (OPTIONAL STEP)
                    self.centeredCollectionViewFlowLayout.minimumLineSpacing = 20
                    
                    // Get rid of scrolling indicators
                    self.collectionView.showsVerticalScrollIndicator = false
                    self.collectionView.showsHorizontalScrollIndicator = true
                }
            }
            
            group.leave()
        }
        
        print("called async")
        
        group.wait()
        
        print(123)
    }
    
}
