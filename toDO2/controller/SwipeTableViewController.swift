//
//  SwipeTableViewController.swift
//  toDO2
//
//  Created by kamal chibrani on 27/10/18.
//  Copyright © 2018 kamal chibrani. All rights reserved.
//

import UIKit
import Realm
import SwipeCellKit

class SwipeTableViewController: UITableViewController , SwipeTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: - table view datasource methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
        
        //        let categoryItem = toDoCategories?[indexPath.row]
        
//        cell.textLabel?.text = toDoCategories?[indexPath.row].name ?? "No categories added yet"
        cell.delegate = self
        
        
        return cell
    }
    
    
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
            print("item deleted")
            
            self.updateTable(at: indexPath)
        }
        
        
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "DeleteIcon")
        
        return [deleteAction]
    }
    
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }
    
    
    func updateTable(at IndexPath : IndexPath)  {
        // update model
    }

 
}
