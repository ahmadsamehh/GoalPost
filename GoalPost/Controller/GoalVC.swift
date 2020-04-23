//
//  ViewController.swift
//  GoalPost
//
//  Created by Ahmad Sameh on 4/11/20.
//  Copyright © 2020 Ahmad Sameh. All rights reserved.
//

import UIKit
import CoreData


class GoalVC: UIViewController , UITableViewDelegate , UITableViewDataSource {

    var totalGoals : [Goal] = []

    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var undoView : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.delegate = self
        myTableView.dataSource = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        reloadTableViewDataByFetching()
        myTableView.reloadData()
    }
    
    func reloadTableViewDataByFetching(){
        
        self.fetchGoal { (complete) in
            if complete{
                if totalGoals.count >= 1{
                    
                    myTableView.isHidden = false
                    
                    
                }else{
                    
                    myTableView.isHidden = true
                }
            }
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return totalGoals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "GoalCell") as? GoalCell {
            
            
            cell.updateGoal(goal: totalGoals[indexPath.row])
            return cell
        }else{
            
            return GoalCell()
        }
    }

    
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
            
            self.deleteGoal(indexPath: indexPath)
            self.reloadTableViewDataByFetching()
            self.myTableView.deleteRows(at: [indexPath], with: .automatic)
   
        }
        
        let addOneAction = UITableViewRowAction(style: .normal, title: "ADD 1") { (rowAction, indexPath) in
            self.setGoalProgress(indexPath: indexPath)
            self.myTableView.reloadRows(at: [indexPath], with: .automatic)
        }
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        addOneAction.backgroundColor = #colorLiteral(red: 0.9176470588, green: 0.662745098, blue: 0.2666666667, alpha: 0.9671179366)
        
        return[deleteAction,addOneAction]
        
    }
    
    
    
    @IBAction func addGoalBtnPressed(_ sender: Any) {
        
    }
    
    
    
    @IBAction func undoBtnPressed(_ sender: Any) {
        self.undoDelete()

       
    }
    
    

        
    func setGoalProgress(indexPath : IndexPath){
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        let chosenGoal = totalGoals[indexPath.row]
        if chosenGoal.goalProgress < chosenGoal.goalCompletionValue {
            
            chosenGoal.goalProgress = chosenGoal.goalProgress+1
        }else{
            
            return
        }
        
        
        do {
            try managedContext.save()
        } catch  {
            debugPrint("Failed \(error.localizedDescription)")
        }
        
        
    }
        
        
    
    func fetchGoal(completion : (_ complete : Bool) -> ()){
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        let myFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Goal")
        
        do {
            totalGoals = try managedContext.fetch(myFetchRequest) as! [Goal]
            print(totalGoals)
            print("successfully fetched")
            completion(true)
        } catch  {
            debugPrint("error fetching \(error.localizedDescription)")
            completion(false)
            print("not fetched")
        }
        

        
        
    }
    
    
    func deleteGoal (indexPath : IndexPath){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else{return}
        managedContext.delete(totalGoals[indexPath.row])
        
        do {
            try managedContext.save()
            print("successfully removed goal")
           
        } catch  {
            debugPrint("error deleting \(error.localizedDescription)")
        }

    }
    
    func undoDelete(){
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else{return}
        managedContext.undoManager = UndoManager()
        managedContext.undo()
        
        do {
            try managedContext.save()
            print("undo successfull")
            

            
        } catch  {
            debugPrint("Failed to undo \(error.localizedDescription)")
        }
        
        
    }
    
}


