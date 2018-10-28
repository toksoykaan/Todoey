//
//  ViewController.swift
//  Todoey
//
//  Created by Kaan TOKSOY on 28.10.2018.
//  Copyright © 2018 Kaan TOKSOY. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    let itemArray = ["Find mike","Buy Eggos", "Destroy Demorgon"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    //MARK - Tableview DataSource Method
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //YANİ ZATEN CHECKMARKI OLAN ŞEYE TIKLARSAN NONE YAPIYO OLMAYANA TIKLARSAN CHECK KOYUYO
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    
}

