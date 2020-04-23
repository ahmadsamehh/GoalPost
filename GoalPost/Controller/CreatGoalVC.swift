//
//  CreatGoalVC.swift
//  GoalPost
//
//  Created by Ahmad Sameh on 4/11/20.
//  Copyright © 2020 Ahmad Sameh. All rights reserved.
//

import UIKit

class CreatGoalVC: UIViewController , UITextViewDelegate{

    
    @IBOutlet weak var goalTextView: UITextView!
    
    @IBOutlet weak var shortTermBtnOutlet: UIButton!
    
    @IBOutlet weak var longTermBtnOutlet: UIButton!
    
    @IBOutlet weak var nextBtnOutlet: UIButton!
    
    
    var goalType : GoalType = .shortTerm
    
    override func viewDidLoad() {
        super.viewDidLoad()


        shortTermSelected()
        goalTextView.delegate = self
        nextBtnOutlet.bindToKeyboard()
        
    }
    
    @IBAction func shortTermBtnPressed(_ sender: Any) {

        shortTermSelected()
        
    }
    
    
    @IBAction func longTermBtnPressed(_ sender: Any) {
        

        longTermSelected()
    }
    
    
    
    @IBAction func nextBtnPressed(_ sender: Any) {
        if (goalTextView.text != "" && goalTextView.text != "What is your goal?") {
            
            guard let cgVC = storyboard?.instantiateViewController(withIdentifier: "finishGoalVC") as? FinishGoalVC else{ return}
            cgVC.initGoal(goalDescription: goalTextView.text , goalType: goalType)
            
         
            present(cgVC, animated: true, completion: nil)
        }
        
        
    }
    
    @IBAction func BackBtnPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
    func shortTermSelected(){
        shortTermBtnOutlet.buttonSelectedColor()
        longTermBtnOutlet.buttonDeselectedColor()
        goalType = .shortTerm
        
    }
    
    func longTermSelected(){
        longTermBtnOutlet.buttonSelectedColor()
        shortTermBtnOutlet.buttonDeselectedColor()
        goalType = .longTerm
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        goalTextView.text = ""
    }

}
