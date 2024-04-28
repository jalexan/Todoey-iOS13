//
//  TodoItemModel.swift
//  Todoey
//
//  Created by Julie Alexan on 4/27/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

class TodoItemModel : Encodable, Decodable {
    var item: String = ""
    var isDone: Bool = false
    
    init(item: String, isDone: Bool) {
        self.item = item
        self.isDone = isDone
    }

}
