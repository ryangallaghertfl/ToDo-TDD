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
    
    func test_ToDoItem_init_whenGivenTitle_ShouldSetExpectedTitle_Equal() {
        let item = ToDoItem(title: "Dummy")
        XCTAssertEqual(item.title, "Dummy")
    }
    
    func test_ToDoItem_init_whenGivenDescription_ShouldSetExpectedDescription_Equal() {
        let item = ToDoItem(title: "Dummy", itemDescription: "Dummy Description")
        XCTAssertEqual(item.itemDescription, "Dummy Description")
    }
    
    func test_ToDoItem_init_ShouldSetExpectedTimestamp() throws {
        //added throws due to unwrap, timestamp is optional
        let dummyTimestamp: TimeInterval = 42.0
        let item = ToDoItem(title: "Dummy", timestamp: dummyTimestamp)
        let timestamp = try XCTUnwrap(item.timestamp)
        XCTAssertEqual(timestamp, dummyTimestamp, accuracy: 0.000_001)
    }
    
    func test_ToDoItem_init_whenGivenLocation_ShouldSetExpectedLocation_Equal() {
        let dummyLocation = Location(name: "Dummy Name")
        let item = ToDoItem(title: "Dummy Title", location: dummyLocation)
        XCTAssertEqual(item.location?.name, dummyLocation.name)
    }
    
    func test_ToDoItem_ShouldAssertEqual_asPropertiesAreSame() {
        let someLocation = Location(name: "Some Name")
        let item1 = ToDoItem(title: "Test", itemDescription: "Description", timestamp: 123456789, location: someLocation)
        let item2 = ToDoItem(title: "Test", itemDescription: "Description", timestamp: 123456789, location: someLocation)

        XCTAssertEqual(item1.title, item2.title, "ToDoItems should be equal")
        XCTAssertEqual(item1.itemDescription, item2.itemDescription, "ToDoItems should be equal")
        XCTAssertEqual(item1.timestamp, item2.timestamp, "ToDoItems should be equal")
        XCTAssertEqual(item1.location, item2.location, "ToDoItems should be equal")
    }
    
    func test_ToDoItem_ShouldAssertNotEqual_asPropertiesAreDifferent() {
        let someLocation = Location(name: "Some Name")
        let otherLocation = Location(name: "Other name")
        let item1 = ToDoItem(title: "Test", itemDescription: "Description", timestamp: 123456789, location: someLocation)
        let item2 = ToDoItem(title: "Test", itemDescription: "Description", timestamp: 987654321, location: otherLocation)

        XCTAssertNotEqual(item1.location, item2.location, "ToDoItems should not be equal as properties differ")
    }


}
