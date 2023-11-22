//
//  ToDoItemInputViewTests.swift
//  ToDo-TDDTests
//
//  Created by Ryan Gallagher on 22/11/2023.
//

import XCTest
@testable import ToDo_TDD
import ViewInspector

extension ToDoItemInputView {}

final class ToDoItemInputViewTests: XCTestCase {
    
    var sut: ToDoItemInputView!
    var toDoItemData: ToDoItemData!

    override func setUpWithError() throws {
        toDoItemData = ToDoItemData()
        sut = ToDoItemInputView(data: toDoItemData)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        toDoItemData = nil
    }

    func test_ToDoItemInputView_titleInput_shouldSetValueInData_AssertsTrue() throws {
        let expected = "dummy title"
    try sut
        .inspect() //allows to to inspect the SwiftUI file
        .find(ViewType.TextField.self) //call find on the return type
        .setInput(expected) //simulates user input
    
        let input = toDoItemData.title
        XCTAssertEqual(input, expected)
    }

}
