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
        TextField("Title", text: $data.title)
    }
}

#Preview {
    ToDoItemInputView(data: ToDoItemData())
}
