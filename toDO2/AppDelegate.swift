//
//  AppDelegate.swift
//  toDO2
//
//  Created by kamal chibrani on 05/10/18.
//  Copyright © 2018 kamal chibrani. All rights reserved.
//

import UIKit
import RealmSwift
//import SwipeCellKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       

        
   
        
        do{
            let realm = try Realm()
           try realm.write {
             
            }
            
        }catch{
            print("error in initializing realm database \(error)")
        }
        
        return true
    }



    
    



}

