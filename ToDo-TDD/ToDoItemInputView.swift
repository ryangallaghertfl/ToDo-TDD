//
//  ToDoItemInputView.swift
//  ToDo-TDD
//
//  Created by Ryan Gallagher on 22/11/2023.
//

import SwiftUI

struct ToDoItemInputView: View {
    @ObservedObject var data:  ToDoItemData
    var didAppear: ((Self) -> Void)?
    
    var body: some View {
    VStack {
        TextField("Title", text: $data.title)
        Toggle("Add Date", isOn: $data.withDate)
        if data.withDate {
            DatePicker("Date", selection: $data.date)
        }
    }
    }
}

#Preview {
    ToDoItemInputView(data: ToDoItemData())
}
