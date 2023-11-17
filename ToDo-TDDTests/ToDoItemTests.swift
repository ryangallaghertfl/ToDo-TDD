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
    
    func test_init_whenGivenTitle_setsTitle() {
        let item = ToDoItem(title: "Dummy")
        XCTAssertEqual(item.title, "Dummy")
    }
    
    func test_init_whenGivenDescription_setsDescription() {
        let item = ToDoItem(title: "Dummy", itemDescription: "Dummy Description")
        XCTAssertEqual(item.itemDescription, "Dummy Description")
    }


}
