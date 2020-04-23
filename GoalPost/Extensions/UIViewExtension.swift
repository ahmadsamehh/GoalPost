//
//  UIViewExtension.swift
//  GoalPost
//
//  Created by Ahmad Sameh on 4/12/20.
//  Copyright © 2020 Ahmad Sameh. All rights reserved.
//

import UIKit

extension UIView{
    func bindToKeyboard() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(KeyBoardWillChange(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        
        
    }
    
    
    @objc func KeyBoardWillChange(_ notification : NSNotification){
        let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        
        let curve = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        
        let startingFrame = (notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        
        let endFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        let deltaY = endFrame.origin.y - startingFrame.origin.y
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIView.KeyframeAnimationOptions(rawValue: curve), animations: {
            self.frame.origin.y += deltaY
        }, completion: nil)
        
        
        
    }
    
    
    
}
