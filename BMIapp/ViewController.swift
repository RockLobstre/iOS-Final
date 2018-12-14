//
//  ViewController.swift
//  BMIapp
//
//  Created by Matin Salehi on 2018-12-13.
//  Copyright © 2018 Matin Salehi. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    var tasksList: [NSManagedObject] = []

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")! as! TaskViewCell
        
        cell.Weight.text = tasksList[indexPath.row].value(forKey: "weight") as? String
        cell.BMI.text = tasksList[indexPath.row].value(forKey: "bmi") as? String
        cell.Date.text = tasksList[indexPath.row].value(forKey: "date") as? String
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //fetch data from db when view loads
        super.viewWillAppear(animated)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Task")
        
        do {
            tasksList = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Fetch error: \(error)")
        }
    }
    

    @IBAction func addTask(_ sender: UIBarButtonItem) {
        //Create pop-up modal to enter new task name
        
        let alert = UIAlertController(title: "New BMI?",
                                      message: "Add new Weight",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Add",
                                       style: .default) {
                                        //get value from text field inside pop-up modal and save it
                                        [weak self] action in
                                        
                                        guard let textField = alert.textFields?.first,
                                            let weightOfTask = textField.text else {
                                                return
                                        }
                                        
                                        self?.saveTask(weight: weightOfTask)
                                        self?.tableView.reloadData()
                                        
                                        
                                        //add task to tasks
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
        
    }
    
    func saveTask(weight: String) {
        //save task to DB
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Task", in: managedContext)!
        
        let task = NSManagedObject(entity: entity, insertInto: managedContext)
        
        //Now date
        let date = Date()
        
        task.setValue(customDateFormat(date: date), forKey: "date")
        
        task.setValue(weight, forKey: "weight")
        
        if let text5 = UserDefaults.standard.string(forKey: "savedHeight") {
            var result: Double = Double(weight)! / Double(pow(Double(text5)!,2))
            task.setValue(String(result), forKey: "bmi")
        }
        
        
        do {
            try managedContext.save()
            tasksList.append(task)
        } catch let error as NSError {
            print("Saving error: \(error)")
        }
        
    }
    
    func customDateFormat(date: Date) -> String{
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateString = dateFormatter.string(from: date as Date)
        
        return dateString
    }
}

