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
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBAction func ChatButton(_ sender: UIButton) {
        print("Starting chat with: \(nameLabel!.text)")
    }
    
    var hasGradient = false
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
    
    @IBOutlet weak var ActInd: UIActivityIndicatorView!
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
        userCell.nameLabel.text = users[indexPath.row].name
        
        
        UIGraphicsBeginImageContext(userCell.frame.size)
        users[indexPath.row].pfp.draw(in: userCell.bounds)

        if let image = UIGraphicsGetImageFromCurrentImageContext(){
            UIGraphicsEndImageContext()
            userCell.backgroundColor = UIColor(patternImage: image)
        }else{
            UIGraphicsEndImageContext()
            debugPrint("Image not available")
         }
        
        let gradient = CAGradientLayer()
        gradient.frame = userCell.bounds
        let startColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        let endColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7).cgColor
        gradient.colors = [startColor, endColor]
        if(!userCell.hasGradient) {
            userCell.layer.insertSublayer(gradient, at: 0)
            userCell.hasGradient = true
        }
        return userCell
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let cellPercentWidth: CGFloat = 0.7
    var centeredCollectionViewFlowLayout: CenteredCollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let query = db.collection("users").whereField("data.accountType", isEqualTo: "psychologist")
        let group = DispatchGroup()
        
        self.ActInd.startAnimating()
        
        query.getDocuments(completion: { QuerySnapshot, err in
            if let e = err {
                print(e)
            }
            else {
                for document in QuerySnapshot!.documents {
                    let userID = document.documentID
                    
                    let storageRef = self.storage.reference()
                    let pfpRef = storageRef.child("profilePics/\(userID).png")
                    
                    let data = document["data"] as? [String: Any]
                    let name = data!["name"] as! String
                    let birthday = data!["birthday"] as! String
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd-MM-yyyy"
                    let birthdayDate = dateFormatter.date(from: birthday)
                    let age = Int(birthdayDate!.timeIntervalSinceNow / (365 * 24 * 60 * 60) * -1)
                    
                    // let preferences = document["preferences"] as? [String: Any]
                    
                    group.enter()
                    pfpRef.getData(maxSize: 2 * 1024 * 1024) { data, error in
                        if let e = error {
                            print(e)
                        } else {
                            let userpfp = UIImage(data: data!)
                            self.users.append(User(
                                "\(name), \(age)",
                                userpfp ?? UIImage(named: "defaultPFP")!
                            ))
                        }
                        group.leave()
                    }
                }
            }
            group.notify(queue: .main) {
                self.users.sort {
                    $0.name < $1.name
                }
                self.ActInd.isHidden = true
                self.displayCards()
            }
        })
    }
    
    func displayCards() {
        self.centeredCollectionViewFlowLayout = self.collectionView.collectionViewLayout as? CenteredCollectionViewFlowLayout
        
        self.collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.centeredCollectionViewFlowLayout.itemSize = CGSize(
            width: self.view.bounds.width * self.cellPercentWidth,
            height: self.view.bounds.height * self.cellPercentWidth * self.cellPercentWidth
        )
        
        self.centeredCollectionViewFlowLayout.minimumLineSpacing = 20
        
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.showsHorizontalScrollIndicator = false
    }
}
