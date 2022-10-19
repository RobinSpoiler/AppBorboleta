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
    @IBOutlet weak var Img: UIImageView!
    @IBOutlet weak var percentage: UILabel!
    
    var userID: String? = nil
    let db = Firestore.firestore()
    
    // redireccionar a chat
    @IBAction func ChatButton(_ sender: UIButton) {
        print("Starting chat with: \(userID!)")
    }
    
    @IBOutlet weak var MatchRateRing: CircularProgressView!
}

struct User {
    var id: String
    var name: String
    var age: Int
    var pronouns: String
    var matchRate: Int
    var pfp: UIImage
    
    init(_ id: String, _ name: String, _ pronouns: String, _ age: Int, _ matchRate: Int, _ pfp: UIImage) {
        self.id = id
        self.name = name
        self.pronouns = pronouns
        self.age = age
        self.matchRate = matchRate
        self.pfp = pfp
    }
}

class MatchesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toChatFromMatches" else { return }
        guard let cell = sender as? UICollectionViewCell else { return }
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        guard let dest = segue.destination as? ChatViewController else { return }
        let i = indexPath.row
        
        let currentUser = Auth.auth().currentUser!.email!
        let cellUser = self.users[i]
        let selectedUser = cellUser.id
        
        for activeChat in self.activeChats! {
            let with = activeChat["with"] as! String
            let chatID = activeChat["chatID"] as! String
            
            // se encontro chat con psicologo seleccionado
            if selectedUser == with {
                print(123)
                print(chatID)
                print(selectedUser)
                print(with)
                let chat = Chat(
                    chatID: chatID,
                    pfp: cellUser.pfp,
                    with: selectedUser,
                    name: cellUser.name,
                    message: Message(message: " ", sender: " ", timestamp: " ")
                )
                dest.chat = chat
            }
        }
        // se buscaron todos los chats activos y no se encontro el chat con el psicologo
        // crear chat
        if dest.chat == nil {
            let userDocRef = db.collection("users").document((Auth.auth().currentUser?.email!)!)
            let receiverDocRef = db.collection("users").document(cellUser.id)
            let chatsRef = db.collection("chats")
            
            let chat = Chat(
                chatID: "\(currentUser)&&\(selectedUser)",
                pfp: cellUser.pfp,
                with: selectedUser,
                name: cellUser.name,
                message: Message(message: " ", sender: " ", timestamp: " ")
            )
            
            chatsRef.document("\(currentUser)&&\(selectedUser)").setData([
                "messages": []
            ])
            
            userDocRef.updateData([
                "activeChats": FieldValue.arrayUnion([
                    [
                        "chatID": "\(currentUser)&&\(selectedUser)",
                        "chatName": cellUser.name,
                        "with": cellUser.id,
                        "lastMessage": [
                            "message": "Hola",
                            "sender": currentUser,
                            "time": "20-10-2022 14:12:32"
                        ]
                    ]
                ])
            ])
            
            receiverDocRef.updateData([
                "activeChats": FieldValue.arrayUnion([
                    [
                        "chatID": "\(currentUser)&&\(selectedUser)",
                        "chatName": cellUser.name,
                        "with": cellUser.id,
                        "lastMessage": [
                            "message": "Hola",
                            "sender": currentUser,
                            "time": "20-10-2022 14:12:32"
                        ]
                    ]
                ])
            ])
            
            dest.chat = chat
        }
    }
    
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
        userCell.nameLabel.text = "\(users[indexPath.row].name) (\(users[indexPath.row].pronouns)), \(users[indexPath.row].age)"
        userCell.userID = users[indexPath.row].id
        userCell.MatchRateRing.trackColor = UIColor.lightGray
        userCell.MatchRateRing.progressColor = UIColor.white
        userCell.MatchRateRing.setProgressWithAnimation(
            duration: 0,
            value: Float(users[indexPath.row].matchRate) / 100.0)
        userCell.percentage.text = "\(users[indexPath.row].matchRate)%"
        userCell.layer.cornerRadius = 16

        userCell.Img.image = users[indexPath.row].pfp
        userCell.Img.layer.cornerRadius = 16
        
        return userCell
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let cellPercentWidth: CGFloat = 0.7
    var centeredCollectionViewFlowLayout: CenteredCollectionViewFlowLayout!
    var activeChats: [ [String: Any] ]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let query = db.collection("users").whereField("data.accountType", isEqualTo: "psychologist")
        let group = DispatchGroup()
        
//        let activeChats: [ [String: Any] ] = []
        
        self.ActInd.startAnimating()
        
        let userDocRef = db.collection("users").document((Auth.auth().currentUser?.email!)!)
        
        
        userDocRef.getDocument { document, error in
            if let document = document, document.exists {
                let userPreferences = document["preferences"] as! [String: Any]
                self.activeChats = document["activeChats"] as? [ [String: Any] ]
                
                if self.activeChats == nil {
                    userDocRef.updateData(["activeChats" : []])
                }
//                print(userPreferences?.count)
                query.getDocuments(completion: { QuerySnapshot, err in
                    if let e = err {
                        print(e)
                    }
                    else {
                        for document in QuerySnapshot!.documents {
                            let userID = document.documentID
                            
                            let storageRef = self.storage.reference()
                            let pfpRef = storageRef.child("profilePics/\(userID).png")
                            
                            let data = document["data"] as! [String: Any]
                            let name: String = data["name"] as! String
                            let pronouns: String = data["pronouns"] as! String
                            let birthday: String = data["birthday"] as! String
                            let age: Int = AppiOS.Calculate().Age(birthday)
                            
                            let preferences = document["preferences"] as? [String: Any]
                            let matchRate: Int = AppiOS.Calculate().MatchRate(userPreferences, preferences!)
                            
                            group.enter()
                            pfpRef.getData(maxSize: 2 * 1024 * 1024) { data, error in
                                if let e = error {
                                    print(e)
                                } else {
                                    let userpfp = UIImage(data: data!)
                                    self.users.append(User(
                                        document.documentID,
                                        name,
                                        pronouns,
                                        age,
                                        matchRate,
                                        userpfp ?? UIImage(named: "defaultPFP")!
                                    ))
                                }
                                group.leave()
                            }
                        }
                    }
                    group.notify(queue: .main) {
                        self.users.sort {
                            $0.matchRate > $1.matchRate
                        }
                        self.ActInd.isHidden = true
                        self.displayCards()
                    }
                })
            } else {
                print("Document does not exist")
            }
        }
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
