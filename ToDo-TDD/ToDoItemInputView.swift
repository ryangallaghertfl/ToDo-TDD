//
//  ToDoItemInputView.swift
//  ToDo-TDD
//
//  Created by Ryan Gallagher on 22/11/2023.
//

import SwiftUI

struct ToDoItemInputView: View {
    @ObservedObject var data: ToDoItemData
    @State var withDate = false
    var didAppear: ((Self) -> Void)?
    
    var body: some View {
    VStack {
        TextField("Title", text: $data.title)
        Toggle("Add Date", isOn: $withDate)
        if withDate {
            DatePicker("Date", selection: $data.date)
        }
    }
    .onAppear { self.didAppear?(self) }
    }
}

#Preview {
    ToDoItemInputView(data: ToDoItemData())
}
