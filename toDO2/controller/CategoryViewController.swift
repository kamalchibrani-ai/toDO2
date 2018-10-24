//
//  CategoryViewController.swift
//  toDO2
//
//  Created by kamal chibrani on 09/10/18.
//  Copyright © 2018 kamal chibrani. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var toDoCategories:Results<Category>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loadcategory()

    
    }

    // MARK:- table view datasource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoCategories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoTableCategoryCell", for: indexPath)
        let categoryItem = toDoCategories?[indexPath.row]
        
        cell.textLabel?.text = categoryItem?.name ?? "No categories added yet"
        
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
