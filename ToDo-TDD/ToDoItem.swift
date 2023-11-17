//
//  ToDoItem.swift
//  ToDo-TDD
//
//  Created by Ryan Gallagher on 17/11/2023.
//

import Foundation

struct ToDoItem {
    let title: String
    let itemDescription: String?
    
    //default value for itemDescription
    init(title: String, itemDescription: String? = nil) {
        self.title = title
        self.itemDescription = itemDescription
    }
}
