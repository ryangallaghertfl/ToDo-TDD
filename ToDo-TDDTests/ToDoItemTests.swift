//
//  ToDoItemTests.swift
//  ToDo-TDDTests
//
//  Created by Ryan Gallagher on 17/11/2023.
//

import XCTest
@testable import ToDo_TDD

final class ToDoItemTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_init_takesTitle() {
        let item = ToDoItem(title: "Dummy")
        XCTAssertNotNil(item, "item should not be nil")
    }
    
    func test_init_takesTitleAndDescription() {
        _ = ToDoItem(title: "Dummy", itemDescription: "Dummy Description")
    }


}
