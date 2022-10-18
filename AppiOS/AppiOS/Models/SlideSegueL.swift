//
//  SlideSegueL.swift
//  AppiOS
//
//  Created by Jorge Delgado on 17/10/22.
//

import Foundation
import UIKit

class SlideSegueL: UIStoryboardSegue {
    
    enum Direction: Int {
        case Left = 1
        case Right = -1
    }
    
    // MARK: - Properties
    var direction = Direction.Right
    
    // MARK: -
    override func perform() {
        let srcVc = self.source
        let destVc = self.destination
        
        
        let destView = destVc.view.snapshotView(afterScreenUpdates: true)
        var frame = destView!.frame
        frame.origin.x = CGFloat(direction.rawValue) * srcVc.view.frame.width
        destView!.frame = frame
        srcVc.view.addSubview(destView!)
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            let x = -CGFloat(self.direction.rawValue) * srcVc.view.bounds.width
            let slide = CGAffineTransformMakeTranslation(x, 0)
            srcVc.view.transform = slide
        }) { (finished: Bool) -> Void in
            srcVc.present(destVc, animated: false, completion: nil)
            
            destView!.removeFromSuperview()
        }
        
    }
}
