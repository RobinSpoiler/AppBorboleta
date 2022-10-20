//
//  Calculate.swift
//  AppiOS
//
//  Created by Jorge Delgado on 12/10/22.
//

import Foundation

struct Calculate {
    func MatchRate(_ p1p: [String: Any], _ p2p: [String: Any]) -> Int {
        var matchRate: Float = 0
        let n = p1p.count
        let ponderation: Float = Float(100) / Float(n)
        
        for i in 1...6 {
            if i == 5 {
                continue
            }
            if (p1p["q\(i)"] as! Int) == (p2p["q\(i)"] as! Int) {
                matchRate += ponderation
            }
        }
        
        let p1q5 = p1p["q5"] as! [Int]
        let p2q5 = p2p["q5"] as! [Int]
        
        for i in p1q5 {
            if p2q5.contains(i) {
                matchRate += ponderation
                break
            }
        }
        
        return Int(matchRate)
    }
    
    func Age(_ birthday: String) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let birthdayDate = dateFormatter.date(from: birthday)
        return Int(birthdayDate!.timeIntervalSinceNow / (365 * 24 * 60 * 60) * -1)
    }
}
