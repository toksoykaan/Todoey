//
//  ViewController.swift
//  Todoey
//
//  Created by Kaan TOKSOY on 28.10.2018.
//  Copyright © 2018 Kaan TOKSOY. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    var itemArray = [Items]() //Items classından object yaratıyoruz...
    let defaults = UserDefaults.standard
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")//Plist'in kaydedileceği memorydeki yer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
    }
    
    //MARK - Tableview DataSource Method
    //Kaç item var table'da
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    //Listin içindeki cell'lerin özelliklerini ve tanımlaması yapıyoruz
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
        
    }
    //MARK - TableView Delegate Methods
    //Hangi cell'i seçti onu belirliyoruz ve done mu değil mi onun özelliğini belirliyoruz
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //YANİ ZATEN CHECKMARKI OLAN ŞEYE TIKLARSAN NONE YAPIYO OLMAYANA TIKLARSAN CHECK KOYUYO
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //MARK - Add New Items
    //Sağ yukarıdaki artı işaretine basılınca item ekleme windowu açıyoruz
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem){
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todo Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What will happen once the user clicks the Add Item button on our UIAlert
            let newItem = Items()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
        
            self.saveItems()
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert,animated:true,completion: nil)
    }
    
    //MARK - Model Manupulation Method -> Adds the Item added and edited to Plist
    //Encode ediyoruz (plak'a yazıyoruz müziği)
    func saveItems() {
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }catch{
            print(error)
        }
        self.tableView.reloadData() //Refreshs the Ekran
    }
    //Decode yapıyoruz, plakı takıp müzik dinliyoruz.
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
            itemArray = try decoder.decode([Items].self, from: data)
            }catch{
                print(error)
            }
    }
}
}

