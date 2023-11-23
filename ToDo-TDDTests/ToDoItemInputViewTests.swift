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
    var apiClientMock: APIClientMock!

    override func setUpWithError() throws {
        toDoItemData = ToDoItemData()
        apiClientMock = APIClientMock()
        sut = ToDoItemInputView(data: toDoItemData, apiClient: apiClientMock)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        toDoItemData = nil
        apiClientMock = nil
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
    
    func test_ToDoItemInputView_shouldAllowLocationNameInput_assertsTrue() throws {
        let expected = "dummy location"
        try sut
            .inspect()
            .find(ViewType.TextField.self,
                  where: { view in
                let label = try view
                    .labelView()
                    .text()
                    .string()
                return label == "Location name"}).setInput(expected)
        let input = toDoItemData.locationName
        XCTAssertEqual(input, expected)
    }
    
    func test_ToDoItemInputView_shouldHaveASaveButton_noThrow() throws {
        XCTAssertNoThrow(try sut.inspect()
        .find(ViewType.Button.self, where: { view in
            let label = try view
                .labelView()
                .text()
                .string()
            return label == "Save"
        }))
    }
    
    func test_ToDoItemInputView_saveButton_shouldFetchCoordinate_assertsTrue() throws {
        toDoItemData.title = "dummy title"
        let expected = "dummy address"
        toDoItemData.addressString = expected
        try sut
            .inspect()
            .find(ViewType.Button.self,
                  where: { view in
                let label = try view
                    .labelView()
                    .text()
                    .string()
                return label == "Save"
                })
            .tap()
        XCTAssertEqual(apiClientMock.coordinateAddress, expected)
    }
    
    func test_ToDoItemInputView_save_whenAddressEmpty_shouldNotFetchCoordinate() throws {
        toDoItemData.title = "dummy title"
        try sut
            .inspect()
            .find(ViewType.Button.self, where: { view in let label = try view
                    .labelView()
                    .text()
                    .string()
                return label == "Save"
            })
            .tap()
        XCTAssertNil(apiClientMock.coordinateAddress)
    }

}
