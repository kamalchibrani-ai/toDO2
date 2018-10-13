//
//  Item.swift
//  toDO2
//
//  Created by kamal chibrani on 13/10/18.
//  Copyright © 2018 kamal chibrani. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
}


let parentCategory = LinkingObjects(fromType: Category.self, property: "items")
