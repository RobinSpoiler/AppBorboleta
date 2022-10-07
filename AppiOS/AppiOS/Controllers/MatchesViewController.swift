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
}

class MatchesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var users: [User] = []
    var current = 0
    
    let storage = Storage.storage()
    
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
        userCell.contentMode = UIView.ContentMode.scaleToFill
        return userCell
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let cellPercentWidth: CGFloat = 0.7
    var centeredCollectionViewFlowLayout: CenteredCollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let db = Firestore.firestore()
        let usersCollection = db.collection("users")
        let query = usersCollection.whereField("data.accountType", isEqualTo: "psychologist")

        query.getDocuments(){ snapshot, err in
            if let e = err {
                print(e)
            }
            else {
                
                for document in snapshot!.documents {
                    let userEmail = document.documentID
                    
                    let storageRef = Storage.storage().reference()
                    
                    let pfpRef = storageRef.child("profilePics/\(userEmail).png")
                    pfpRef.getData(maxSize: 1 * 1024 * 1024) {
                        data, e in
                        if let err = e {
                            print(err)
                        }
                        else {
                            self.users.append(User(userEmail, UIImage(data: data!)!))
                            self.displayCards()
                        }
                    }
                }
            }
        }
    }
    
    func getUserPFP(userEmail mail: String) -> UIImage? {
        let storageRef = Storage.storage().reference()
        let pfpRef = storageRef.child("profilePics/\(mail).png")
        
        var pfpImg: UIImage? = nil
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        pfpRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let e = error {
                print(e)
            } else {
                pfpImg = UIImage(data: data!)
            }
        }
        
        return pfpImg
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
