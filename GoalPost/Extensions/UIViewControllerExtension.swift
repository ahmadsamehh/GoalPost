//
//  UIViewControllerExtension.swift
//  GoalPost
//
//  Created by Ahmad Sameh on 4/13/20.
//  Copyright © 2020 Ahmad Sameh. All rights reserved.
//

import UIKit

extension UIViewController{
    
    func dismissDetail(){
        
     let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype(rawValue: kCATransition)
        self.view.window.add
        dismiss(animated: false, completion: nil)
        
    }
}
