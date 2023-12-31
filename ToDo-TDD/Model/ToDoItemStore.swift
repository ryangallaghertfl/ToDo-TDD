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
        loadItems()
    }
    
    func add(_ item: ToDoItem) {
        items.append(item)
        saveItems()
    }
    
    func check(_ item: ToDoItem) {
        var mutableItem = item
        mutableItem.done = true
        if let index = items.firstIndex(of: item){
            items[index] = mutableItem //sets new value, which will notify subs
            saveItems()
        }
    }
    
    private func loadItems() {
        let url = FileManager.default.documentsURL(name: fileName)
        do {
            let data = try Data(contentsOf: url)
            items = try JSONDecoder().decode([ToDoItem].self, from: data)
        }
        catch {
            print("error: \(error)")
        }
    }
    
    
    private func saveItems() {
        let url = FileManager.default
            .documentsURL(name: fileName)
        
        do {
            //encodes items array to JSON
            let data = try JSONEncoder().encode(items)
            try data.write(to: url)
        } catch {
            print("error: \(error)")
        }
    }
}

//MARK: conforming to ToDoItemStoreProtocol to perform test double

extension ToDoItemStore: ToDoItemStoreProtocol {
    //check already implemented above
}

//MARK: protocol for test double purposes

protocol ToDoItemStoreProtocol {
    var itemPublisher: CurrentValueSubject<[ToDoItem], Never> { get set }
    
    func check(_: ToDoItem)
}
