//
//  FinishGoalVC.swift
//  GoalPost
//
//  Created by Ahmad Sameh on 4/12/20.
//  Copyright © 2020 Ahmad Sameh. All rights reserved.
//

import UIKit

class FinishGoalVC: UIViewController , UITextFieldDelegate{

    @IBOutlet weak var goalCountTextField: UITextField!
    
    @IBOutlet weak var createGoalBtn: UIButton!
    
    var goalDescription : String = ""
    var goalType : GoalType = .shortTerm
    
    func initGoal(goalDescription : String , goalType : GoalType){
        
        self.goalDescription = goalDescription
        self.goalType = goalType
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createGoalBtn.bindToKeyboard()
        goalCountTextField.delegate = self
        print(goalDescription)
        print(goalType)
        
       
    }
    
    
    @IBAction func createGoalBtnPressed(_ sender: Any) {
        if goalCountTextField.text != "" {
            
            self.saveData { (complete) in
                if complete{
                    guard let goalVC = storyboard?.instantiateViewController(withIdentifier: "goalVC") as? GoalVC else { return }
                    present(goalVC, animated: true, completion: nil)
                    
                    
                }
            }
        }
        
        
        
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func saveData(completion: (_ finished:Bool) -> ()){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else{ return }
        let goal = Goal(context: managedContext)
        goal.goalDescription = goalDescription
        goal.goalType = goalType.rawValue
        goal.goalCompletionValue = Int32(goalCountTextField.text!)!
        goal.goalProgress = Int32(0)
        
        
        do {
            try managedContext.save()
            print("Successfully saved")
            completion(true)
            
        }catch{
            
            debugPrint("Couldn't Save \(error.localizedDescription)")
            completion(false)
            
        }
        
        
        
        
        
        
    }
    
}
