//
//  ToDoItemData.swift
//  ToDo-TDD
//
//  Created by Ryan Gallagher on 22/11/2023.
//

import Foundation

class ToDoItemData: ObservableObject {
    @Published var title = ""
    @Published var date = Date()
    @Published var withDate = false
    @Published var itemDescription = ""
    @Published var locationName = ""
    @Published var addressString = ""
}
