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
        Form {
            //uses SwiftUI's section type not UIKit
            SwiftUI.Section {
                TextField("Title", text: $data.title)
                Toggle("Add Date", isOn: $data.withDate)
                if data.withDate {
                    DatePicker("Date", selection: $data.date)
                }
                TextField("Description", text: $data.itemDescription)
            }
            SwiftUI.Section {
                TextField("Location name", text: $data.locationName)
            }
        }
    }
}

#Preview {
    ToDoItemInputView(data: ToDoItemData())
}
