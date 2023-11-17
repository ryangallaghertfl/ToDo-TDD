//
//  ToDoItemStoreTests.swift
//  ToDo-TDDTests
//
//  Created by Ryan Gallagher on 17/11/2023.
//

import XCTest
import Combine
@testable import ToDo_TDD

final class ToDoItemStoreTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_ToDoItemStore_add_shouldPublishChange_AssertEqual() {
        let sut = ToDoItemStore()
        //expectation tests async code as it waits for callbacks
        let publisherExpectation = expectation(description: "Wait for publisher in \(#file)") //why we need this expectation
        var receivedItems: [ToDoItem] = [] //store to todoitems
        let token = sut.itemPublisher //subbing to publisher
            .dropFirst() //drops first published item because we don't needed it
            .sink { items in // subs to the publisher, received items is passed in but the param name is omitted by enclosure; at this point the async code in the test is fone
                receivedItems = items
                publisherExpectation.fulfill() //fulfill tells the test we don't need to wait anymore
            }
        
        let toDoItem = ToDoItem(title: "Dummy")
        sut.add(toDoItem)
        
        wait(for: [publisherExpectation], timeout: 1) //tells test to wait until expectations are fulfilled, if they are not fulfilled then test fails
        token.cancel() //we cancel the publisher
        XCTAssertEqual(receivedItems, [toDoItem])
    }

}
