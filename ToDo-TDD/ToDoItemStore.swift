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
    
    private let fileName: String
    
    //private var holds the ToDoItems
    private var items: [ToDoItem] = [] {
        didSet {
            //when property changes (new item added) it is published
            itemPublisher.send(items)
        }
    }
    
    init(fileName: String = "todoitems") {
        self.fileName = fileName
    }
    
    func add(_ item: ToDoItem) {
        items.append(item)
    }
    
    func check(_ item: ToDoItem) {
        var mutableItem = item
        mutableItem.done = true
        if let index = items.firstIndex(of: item){
            items[index] = mutableItem //sets new value, which will notify subs
        }
    }
    
    private func saveItems() {
        if let url = FileManager.default
            .urls(for: .documentDirectory,
                  in: .userDomainMask)
                .first?
            .appendingPathComponent(fileName) {
            do {
                //encodes items array to JSON
                let data = try JSONEncoder().encode(items)
                try data.write(to: url)
            } catch {
                print("error: \(error)")
            }
        }
    }
}
