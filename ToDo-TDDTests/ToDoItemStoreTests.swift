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
    
    func test_ToDoItemStore_add_shouldPublishChange_AssertEqual() throws {
        //marked throws so if error thrown, it reports test failure
        let sut = ToDoItemStore()
        let toDoItem = ToDoItem(title: "Dummy")
        let receivedItems = try wait(for: sut.itemPublisher) //in case wait method throws
        {
        sut.add(toDoItem)
        }
        XCTAssertEqual(receivedItems, [toDoItem])
    }
    
    func test_ToDoItemStore_check_shouldPublishChangeInDoneItems_AssertsEqual() throws {
      let toDoItem = ToDoItem(title: "Dummy")
      var sut = ToDoItemStore()
      sut.add(toDoItem)
      sut.add(ToDoItem(title: "Dummy 2"))

      let receivedItems = try wait(for: sut.itemPublisher) {
        sut.check(toDoItem)
      }

      let doneItems = receivedItems.filter({ $0.done })
      XCTAssertEqual(doneItems, [toDoItem])
    }

}

//MARK: extension to XCTestCase

extension XCTestCase {
    func wait<T: Publisher>(for publisher: T, afterChange change: () -> Void, file: StaticString = #file, line: UInt = #line) throws -> T.Output where T.Failure == Never {
        //expectation tests async code as it waits for callbacks
        let publisherExpectation = expectation(description: "Wait for publisher in \(#file)") //description is why we need this expectation
        var result: T.Output?
        let token = publisher //subbing to publisher
            .dropFirst() //drops first published item because we don't needed it
            .sink { value in // subs to the publisher, received items is passed in but the param name is omitted by enclosure; at this point the async code in the test is done
                result = value
                publisherExpectation.fulfill() //fulfill tells the test we don't need to wait anymore
    }
        change()
        wait(for: [publisherExpectation], timeout: 1) //tells test to wait until expectations are fulfilled, if they are not fulfilled then test fails
        token.cancel()
        let unwrappedResult = try XCTUnwrap(result, "Publisher did not publish any value", file: file, line: line) //we cancel the publisher
        return unwrappedResult
        }
}
