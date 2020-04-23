//
//  GoalCell.swift
//  GoalPost
//
//  Created by Ahmad Sameh on 4/11/20.
//  Copyright © 2020 Ahmad Sameh. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {

    @IBOutlet weak var goalName : UILabel!
    @IBOutlet weak var goalType : UILabel!
    @IBOutlet weak var goalCount : UILabel!
    @IBOutlet weak var completionView : UIView!
    
    func updateGoal(goal : Goal){
        self.goalName.text = goal.goalDescription
        self.goalType.text = goal.goalType
        self.goalCount.text = "\(goal.goalProgress)"
        
        if goal.goalCompletionValue == goal.goalProgress {
            
            completionView.isHidden = false
        }else{
            
            completionView.isHidden = true
        }
    
        
    }

}
