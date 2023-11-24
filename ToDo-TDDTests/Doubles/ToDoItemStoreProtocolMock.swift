//
//  ToDoItemStoreProtocolMock.swift
//  ToDo-TDDTests
//
//  Created by Ryan Gallagher on 19/11/2023.
//

import Foundation
import Combine
@testable import ToDo_TDD

//stand in test double

class ToDoItemStoreProtocolMock: ToDoItemStoreProtocol {
    var itemPublisher = CurrentValueSubject<[ToDoItem], Never>([])
    var checkLastCallArgument: ToDoItem?
    
    func check(_ item: ToDoItem) {
        checkLastCallArgument = item
    }
}
