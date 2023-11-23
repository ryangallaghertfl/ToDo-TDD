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
    
    func test_ToDoItemInputView_whenWithoutDate_shouldNotShowDateInput_throwsError() {
        XCTAssertThrowsError(try sut.inspect().find(ViewType.DatePicker.self))
    }
    
    func test_ToDoItemInputView_whenWithDate_shouldAllowDateInput_assertsTrue() throws {
        
        let systemVersion = UIDevice.current.systemVersion
           try XCTSkipIf(systemVersion.hasPrefix("16") || systemVersion.hasPrefix("17"), "Toggle's tap() and isOn() are currently unavailable for inspection on iOS 16 and iOS 17")
        let expected = Date()
        try sut.inspect().find(ViewType.Toggle.self).tap()
        try sut.inspect().find(ViewType.DatePicker.self).select(date: expected)
        
        let input = toDoItemData.date
        
        XCTAssertEqual(input, expected)
    }
    
    func test_ToDoItemInputView_shouldAllowDescriptionInput_assertsTrue() throws {
        let expected = "dummy description"
        try sut
            .inspect()
            .find(ViewType.TextField.self,
                  where: { view in
                let label = try view
                    .labelView()
                    .text()
                    .string()
                return label == "Description"}).setInput(expected)
        let input = toDoItemData.itemDescription
        XCTAssertEqual(input, expected)
    }

}
