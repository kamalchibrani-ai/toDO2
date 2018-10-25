//
//  Category.swift
//  toDO2
//
//  Created by kamal chibrani on 13/10/18.
//  Copyright © 2018 kamal chibrani. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
}


