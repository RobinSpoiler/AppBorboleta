//
//  MatchesViewController.swift
//  AppiOS
//
//  Created by Jorge Delgado on 04/10/22.
//

import UIKit
import Firebase
import CenteredCollectionView
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage
import SDWebImage

class UserCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var testLabel: UILabel!
}

struct User {
    var name: String
    var pfp: UIImage
    
    init(_ name: String, _ pfp: UIImage) {
        self.name = name
        self.pfp = pfp
    }
    
    init(_ name: String) {
        self.name = name
        self.pfp = UIImage(named: "defaultPFP")!
    }
}

class MatchesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
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
        userCell.backgroundColor = UIColor(patternImage: users[indexPath.row].pfp)
        return userCell
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let cellPercentWidth: CGFloat = 0.7
    var centeredCollectionViewFlowLayout: CenteredCollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let group = DispatchGroup()
        let query = db.collection("users").whereField("data.accountType", isEqualTo: "psychologist")
        
        group.enter()
        query.getDocuments(completion: { QuerySnapshot, err in
            if let e = err {
                print(e)
            }
            else {
                for document in QuerySnapshot!.documents {
                    let userID = document.documentID
                    self.users.append(User(
                        userID
                    ))
                }
                group.leave()
            }
        })
        group.notify(queue: .main) {
            self.displayCards()
        }
    }
    
    func getPFP(userID: String) -> UIImage {
        let storageRef = storage.reference()
        let pfpReference = storageRef.child("profilePics/\(userID).png")
        
        var returnImg = UIImage(named: "defaultPFP")!
        
        pfpReference.getData(maxSize: 1 * 1024 * 1024) { data, err in
            if let e = err {
                print(e)
            }
            else {
                returnImg = UIImage(data: data!)!
            }
        }
        
        return returnImg
    }
    
    func displayCards() {
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
        self.collectionView.showsHorizontalScrollIndicator = false
    }
}
