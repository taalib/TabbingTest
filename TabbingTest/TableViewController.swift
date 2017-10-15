//
//  TableViewController.swift
//  TabbingTest
//
//  Created by Taalib Minhas on 30/09/2017.
//  Copyright © 2017 Taalib Minhas. All rights reserved.
//

import UIKit
import os.log

class TableViewController: UITableViewController {

    //MARK: Properties
    var todoList = [ToDo]()
    
    @IBOutlet var textField: UITextField!
    
    @IBAction func addBtn(_ sender: Any) {
        
        if textField.text != "" {
                    let todo = ToDo(name: textField.text!)
                    todoList.append(todo)
                    textField.text = ""
                    saveList()
                    tableView.reloadData()
                    print(ToDo.PropertyKey.name)
                    textField.resignFirstResponder()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor.init(red:0.98, green:0.98, blue:0.98, alpha:1.0)

        
        // Load any saved meals, otherwise load sample data.
        if let savedLists = loadList() {
            todoList += savedLists
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Closes keyboard when user touches outside keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return(true)
    }
    
    //MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell
            else {
                fatalError("The dequeued cell is not an instance of TableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let todo = todoList[indexPath.row]
        
        cell.toDoLabel.text = todo.name
        
//        cell.backgroundColor = UIColor.init(red:0.98, green:0.98, blue:0.98, alpha:1.0)
        
        return cell
        
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            todoList.remove(at: indexPath.row)
            saveList()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    //MARK: Private functions
    private func saveList() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(todoList, toFile: ToDo.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Lists successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save lists...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadList() -> [ToDo]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: ToDo.ArchiveURL.path) as? [ToDo]
    }
    
}
