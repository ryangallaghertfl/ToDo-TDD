//
//  ToDoItem.swift
//  ToDo-TDD
//
//  Created by Ryan Gallagher on 17/11/2023.
//

import Foundation

struct ToDoItem {
    
    let id: UUID
    let title: String
    let itemDescription: String?
    let timestamp: TimeInterval?
    let location: Location?
    var done = false
    
    //default value for itemDescription and timestamp
    init(title: String, itemDescription: String? = nil, timestamp: TimeInterval? = nil, location: Location? = nil) {
        self.id = UUID()
        self.title = title
        self.itemDescription = itemDescription
        self.timestamp = timestamp
        self.location = location
    }
}

//MARK: conforms to Equatable

extension ToDoItem: Equatable {
    static func == (lhs: ToDoItem, rhs: ToDoItem) -> Bool {
        return lhs.id == rhs.id
    }
}

//MARK: conforms to Codable

extension ToDoItem: Codable {
    
}

//MARK: conforms to Hashable, so we can use UITableViewDiffableDataSource API

extension ToDoItem: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
