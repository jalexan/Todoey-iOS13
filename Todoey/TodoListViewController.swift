//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    //var todoList = ["Buy Milk", "Call Robbie", "Water the Plants"]
    var todoList = [TodoItemModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.backgroundColor = .blue
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title = "Todo List"
        
        print(dataFilePath!)
        readFromPlist()
        
       /*
        if let items = userDefaults.array(forKey: "UserTodoList") as? [TodoItemModel] {
            self.todoList = items
        }
        */
    }
    
    
    //MARK - TableView Delegates
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "MyCell")
        cell.textLabel?.text = todoList[indexPath.row].item
             
        let item = todoList[indexPath.row]
        cell.accessoryType = (item.isDone) ? .checkmark : .none
                
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = todoList[indexPath.row]
        item.isDone = !item.isDone

        writeToPlist()
        tableView.reloadData()
        
        let vc = TodoDetailsViewController()
        vc.subtitleLabel.text =  todoList[indexPath.row].item

        vc.modalPresentationStyle = .pageSheet
        //present(vc, animated: true)

    }
    
    //MARK - Add Todo List Item Action
    
    @IBAction func addTodoListItem(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add New Todo Item", message: "", preferredStyle: UIAlertController.Style.alert)
        var newTextField = UITextField()
        
        let addAction = UIAlertAction(title: "Add Item", style: .default) { (action) in
            print(newTextField.text as Any)
            if (newTextField.text?.isEmpty == false) {
                self.todoList.append(TodoItemModel(item: newTextField.text!, isDone:false))
                
                self.writeToPlist()
                self.tableView.reloadData()
            }
        }
        
        alert.addTextField { (addNewItemTextField) in
            addNewItemTextField.placeholder = "Enter a new thing to do here"
            newTextField = addNewItemTextField
        }
        
        alert.addAction(addAction)
        present(alert, animated: true, completion: nil)
    }
    
    func writeToPlist() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(todoList)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error writing to or encoding todoList array: \(error)")
        }
    }
    
    func readFromPlist() {
        do {
            if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
                todoList = try decoder.decode([TodoItemModel].self, from: data)  //".self" gives it the actual data type of this object
            }
        } catch {
            print("Error reading from or DE-coding todoList array: \(error)")
        }
        print("Got this from decoder: \(todoList)")
    }
    
}

