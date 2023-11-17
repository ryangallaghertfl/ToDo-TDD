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
    let timestamp: TimeInterval?
    
    //default value for itemDescription and timestamp
    init(title: String, itemDescription: String? = nil, timestamp: TimeInterval? = nil) {
        self.title = title
        self.itemDescription = itemDescription
        self.timestamp = timestamp
    }
}
