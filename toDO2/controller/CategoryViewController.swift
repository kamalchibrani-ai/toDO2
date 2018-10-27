//
//  CategoryViewController.swift
//  toDO2
//
//  Created by kamal chibrani on 09/10/18.
//  Copyright © 2018 kamal chibrani. All rights reserved.
//

import UIKit
import RealmSwift
//import SwipeCellKit

class CategoryViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    
    var toDoCategories:Results<Category>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loadcategory()
        tableView.rowHeight = 80.0

    
    }

    // MARK:- table view datasource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoCategories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = super.tableView(tableView, cellForRowAt: indexPath)
      
//        let categoryItem = toDoCategories?[indexPath.row]
//
                        cell.textLabel?.text = toDoCategories?[indexPath.row].name ?? "No categories added yet"
//
//
//        
        return cell
    }
    
    
    // MARK:- table view delgate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self) // koi bhi row select hone prr segue perform hota hai
        
    }
    //segue pehle prepare hoga
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = toDoCategories?[indexPath.row]
        }
        
    }
    
    // MARK:- data manipulation Methods
    
    func save(category : Category)  {
       
        do{
            try realm.write {
                realm.add(category)
            }
        }
        catch {
            print("error in saving item is \(error)")
        }
        
        tableView.reloadData()
    }
    
    //MARK: - delete using swipe
    
    override func updateTable(at IndexPath: IndexPath) {
        if let  categoryForDeletion = self.toDoCategories?[IndexPath.row]{
                            do{
                                try self.realm.write {
                                    self.realm.delete(categoryForDeletion)
                                }
            
                            }catch {
                                print("error while deleting\(error)")
                            }
            
                        }
    }
    
    func loadcategory()  {
        
         toDoCategories =  realm.objects(Category.self)
        tableView.reloadData()
    }
    
    
    // MARK:-  add button new categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var addCategoryTextField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = addCategoryTextField.text!
            print(addCategoryTextField.text!)
            
            self.save(category: newCategory)
            
            self.tableView.reloadData()
            
        }
        alert.addTextField { (alerttextField) in
            alerttextField.placeholder = "add new category"
            addCategoryTextField = alerttextField
        }
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
    }
    
}

//MARK: - swipe cell delgate methods

//extension CategoryViewController : SwipeTableViewCellDelegate {
//
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
//        guard orientation == .right else { return nil }
//
//        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
//            // handle action by updating model with deletion
//            print("item deleted")
//
//            if let  categoryForDeletion = self.toDoCategories?[indexPath.row]{
//                do{
//                    try self.realm.write {
//                        self.realm.delete(categoryForDeletion)
//                    }
//
//                }catch {
//                    print("error while deleting\(error)")
//                }
//
//            }
//
//        }
//
//
//
//        // customize the action appearance
//        deleteAction.image = UIImage(named: "DeleteIcon")
//
//        return [deleteAction]
//    }
//
//
//    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
//        var options = SwipeOptions()
//        options.expansionStyle = .destructive
//        return options
//    }
//
//}
