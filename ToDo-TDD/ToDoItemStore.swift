//
//  ToDoItemStore.swift
//  ToDo-TDD
//
//  Created by Ryan Gallagher on 17/11/2023.
//

import Foundation
import Combine

class ToDoItemStore {
    //creates CurrentValueSubject publisher that sends arrays of ToDoItems
    //Failure type set to Never means publisher can never fail
    var itemPublisher = CurrentValueSubject<[ToDoItem], Never>([])
    
    //private var holds the ToDoItems
    private var items: [ToDoItem] = [] {
        didSet {
            //when property changes (new item added) it is published
            itemPublisher.send(items)
        }
    }
    
    func add(_ item: ToDoItem) {
        items.append(item)
    }
    
    func check(_ item: ToDoItem) {
        items.append(ToDoItem(title: ""))
    }
}
