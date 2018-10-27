//
//  ViewController.swift
//  toDO2
//
//  Created by kamal chibrani on 05/10/18.
//  Copyright © 2018 kamal chibrani. All rights reserved.
//

import UIKit
import RealmSwift
//import SwipeCellKit

class ToDoViewController: SwipeTableViewController {
    var toDoItems : Results<Item>?
    
    let realm = try!  Realm()
    
    
    var selectedCategory : Category? {
        didSet{
                loadItems()
        }
    }
  //  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext


   // let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
            tableView.rowHeight = 80.0

    }
    
    
    //MARK:- TableView DataSource Method
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if  let item = toDoItems?[indexPath.row]{
            cell.textLabel?.text = item.title
            
            cell.accessoryType =  item.done ?  .checkmark :  .none
            
        }else{
            cell.textLabel?.text = "no items added"
        }
    return cell
    }
    
    
    //MARK:- tableview delegate method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // print(itemArray[indexPath.row])
        
        if let item = toDoItems?[indexPath.row]{
            do{
            try   realm.write {
                item.done = !item.done
            }
            }catch{
                print("error updating \(error)")
            }
        }

//        tableView.reloadData()

        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK:- add new item
    
    @IBAction func addNewItems(_ sender: UIBarButtonItem) {
        
        var addItemTextField = UITextField()
        
        let alert = UIAlertController(title: "add new item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "add item", style: .default) { (action) in
            // what will happen when user will press add new item button
            
            if  let currentCategory = self.selectedCategory{
                do{
                    try  self.realm.write {
                        let newItem = Item()
                       newItem.title = addItemTextField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                    
                }catch{
                    print("error in adding new item\(error)")
                }
                
            self.tableView.reloadData()
        }
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add New Item "
            addItemTextField = alertTextField
            
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        
    
    }
    // MARK:- model manupaltion method
    
    
        func loadItems()  {
            
            toDoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
            tableView.reloadData()
        }
    
    // MARK: - delete cell using swipe
    override func updateTable(at IndexPath: IndexPath) {
        if let  itemForDeletion = self.toDoItems?[IndexPath.row]{
            do{
                try self.realm.write {
                    self.realm.delete(itemForDeletion)
                }
                
            }catch {
                print("error while deleting\(error)")
            }
            
        }
    }
        

}
 

// MARK :- search bar methods

extension ToDoViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        toDoItems = toDoItems?.filter("title CONTAINS [cd] %@", searchBar.text! ).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
    }


    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            loadItems()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
        }
    }
}
}

