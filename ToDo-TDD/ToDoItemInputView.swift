//
//  ToDoItemInputView.swift
//  ToDo-TDD
//
//  Created by Ryan Gallagher on 22/11/2023.
//

import SwiftUI

struct ToDoItemInputView: View {
    @ObservedObject var data: ToDoItemData
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ToDoItemInputView(data: ToDoItemData())
}
