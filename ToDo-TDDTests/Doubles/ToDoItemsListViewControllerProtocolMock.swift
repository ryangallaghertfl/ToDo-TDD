//
//  ToDoItemsListViewControllerProtocolMock.swift
//  ToDo-TDDTests
//
//  Created by Ryan Gallagher on 21/11/2023.
//

import UIKit
@testable import ToDo_TDD

class ToDoItemsListViewControllerProtocolMock: ToDoItemsListViewControllerProtocol {
    
    var selectToDoItemReceivedArguments: (viewController: UIViewController, item: ToDoItem)?
    
    var addToDoItemCallCount = 0
    
    //protocol mock stores the received argument to the call of the delegate method, selectToDoItem(_:item:)
    func selectToDoItem(
    _ viewController: UIViewController, item: ToDoItem) {
        selectToDoItemReceivedArguments = (viewController, item)
    }
    
    func addToDoItem(_ viewController: UIViewController) {
        addToDoItemCallCount += 1
    }
}
