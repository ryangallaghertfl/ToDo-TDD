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
    let location: Location?
    var done = false
    
    //default value for itemDescription and timestamp
    init(title: String, itemDescription: String? = nil, timestamp: TimeInterval? = nil, location: Location? = nil) {
        self.title = title
        self.itemDescription = itemDescription
        self.timestamp = timestamp
        self.location = location
    }
}

extension ToDoItem: Equatable {
    static func == (lhs: ToDoItem, rhs: ToDoItem) -> Bool {
        return lhs.title == rhs.title &&
                      lhs.itemDescription == rhs.itemDescription &&
                      lhs.timestamp == rhs.timestamp &&
                      lhs.location == rhs.location
    }
}
