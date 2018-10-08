//
//  ViewController.swift
//  toDO2
//
//  Created by kamal chibrani on 05/10/18.
//  Copyright © 2018 kamal chibrani. All rights reserved.
//

import UIKit

class ToDoViewController: UITableViewController {
    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

   // let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataFilePath!)
        

        
//        if let   items = defaults.array(forKey: "itemArrayList") as? [Item]{
//            itemArray = items
//        }   ***********************************  need to change it later ***************
        
        loadItem()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    //MARK:- TableView DataSource Method
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoTableItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
      cell.accessoryType =  item.done ?  .checkmark :  .none // this code replaces the code below
        
        
//        if item.done ==  true{
//            cell.accessoryType = .checkmark
//        }
//        else {
//            cell.accessoryType = .none
//        }
        
        
        return cell
    }
    
    
    //MARK:- tableview delegate method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done //this replaces the code below
        
        doCatchBlockForEncoder()
        
//        if  itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        }
//        else{
//            itemArray[indexPath.row].done = false
//
//        }
        
       // tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        if         tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark

        }
        
        tableView.reloadData()

        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK:- add new item
    
    @IBAction func addNewItems(_ sender: UIBarButtonItem) {
        
        var addItemTextField = UITextField()
        
        let alert = UIAlertController(title: "add new item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "add item", style: .default) { (action) in
            // what will happen when user will press add new item button
            let newItem = Item()
            newItem.title = addItemTextField.text!
            print(addItemTextField.text! )

            self.itemArray.append(newItem)
//            let encoder = PropertyListEncoder()
//
//            do{
//                    let data = try encoder.encode(self.itemArray)
//                try data.write(to: self.dataFilePath!)
//
//            }
//            catch{
//                print("error in encoder \(error)")
//            }
//
           self.doCatchBlockForEncoder()
            
            
            
            
            
          //  self.defaults.set(self.itemArray, forKey: "itemArrayList")      deleted
            self.tableView.reloadData()
         //   print(self.itemArray.count)
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add New Item "
            addItemTextField = alertTextField
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    func doCatchBlockForEncoder()  {
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(self.itemArray)
            try data.write(to: self.dataFilePath!)
            
        }
        catch{
            print("error in encoder \(error)")
        }
    }
    
    
    
    func loadItem()  {
        if let data = try?  Data(contentsOf: dataFilePath!){
        let decoder = PropertyListDecoder()
            do {
                        itemArray = try decoder.decode([Item].self, from: data)
            }catch{
                print("error in decoding the content \(error)")
            }
        
    }
    

}

}
