//
//  ToDoItemInputViewDelegateMock.swift
//  ToDo-TDDTests
//
//  Created by Ryan Gallagher on 23/11/2023.
//

import Foundation
@testable import ToDo_TDD

class ToDoItemInputViewDelegateMock: ToDoItemInputViewDelegate {
    var lastToDoItemData: ToDoItemData?
    var lastCoordinate: Coordinate?
    
    func addToDoItem(with data: ToDoItemData, coordinate: Coordinate?) {
        lastToDoItemData = data
        lastCoordinate = coordinate
    }
}
