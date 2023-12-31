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
    
    var sut: ToDoItemStore!

    override func setUpWithError() throws {
        sut = ToDoItemStore(fileName: "dummy_store")
    }

    override func tearDownWithError() throws {
        sut = nil
        let url = FileManager.default.documentsURL(name: "dummy_store")
            try? FileManager.default.removeItem(at: url)
    }
    
    func test_ToDoItemStore_add_shouldPublishChange_AssertEqual() throws {
        //marked throws so if error thrown, it reports test failure
        let toDoItem = ToDoItem(title: "Dummy")
        let receivedItems = try wait(for: sut.itemPublisher) //in case wait method throws
        {
        sut.add(toDoItem)
        }
        XCTAssertEqual(receivedItems, [toDoItem])
    }
    
    func test_ToDoItemStore_check_shouldPublishChangeInDoneItems_AssertsEqual() throws {
      let toDoItem = ToDoItem(title: "Dummy")
      sut.add(toDoItem)
      sut.add(ToDoItem(title: "Dummy 2"))

      let receivedItems = try wait(for: sut.itemPublisher) {
        sut.check(toDoItem)
      }

      let doneItems = receivedItems.filter({ $0.done })
      XCTAssertEqual(doneItems, [toDoItem])
    }
    
    func test_ToDoItemStore_init_shouldLoadPreviousToDoItems() throws {
        
        var sut1: ToDoItemStore? =
        ToDoItemStore(fileName: "dummy_store")
        let publisherExpectation = expectation(description: "Wait for publisher in \(#file)")
        let toDoItem = ToDoItem(title: "Dummy Title")
        sut1?.add(toDoItem) //add item to store
        sut1 = nil //destroy store
        let sut2 = ToDoItemStore(fileName: "dummy_store") //create new store
        var result: [ToDoItem]?
        let token = sut2.itemPublisher.sink { value in //sub to its publisher
            result = value
            publisherExpectation.fulfill()
        }
        wait(for: [publisherExpectation], timeout: 1)
        token.cancel()
        XCTAssertEqual(result, [toDoItem])
    }
    
    func test_ToDoItemStore_init_whenItemIsChecked_shouldLoadPreviousToDoItems_AssertsEqual() throws {
        
        var sut1: ToDoItemStore? = ToDoItemStore(fileName: "dummy_store")
        
        let publisherExpectation = expectation(description: "Wait for publisher in \(#file)")
        
        let toDoItem = ToDoItem(title: "Dummy Title")
        
        sut1?.add(toDoItem)
        sut1?.check(toDoItem)
        sut1 = nil
        
        let sut2 = ToDoItemStore(fileName: "dummy_store")
        
        var result: [ToDoItem]?
        
        let token = sut2.itemPublisher
            .sink { value in
                result = value
                publisherExpectation.fulfill()
            }
        
        wait(for: [publisherExpectation], timeout: 1)
        token.cancel()
        
        XCTAssertEqual(result?.first?.done, true)
        }

}

//MARK: extension to XCTestCase

//helper method to improve failure message
extension XCTestCase {
    func wait<T: Publisher>(for publisher: T, afterChange change: () -> Void, file: StaticString = #file, line: UInt = #line) throws -> T.Output where T.Failure == Never {
        //expectation tests async code as it waits for callbacks
        let publisherExpectation = expectation(description: "Wait for publisher in \(#file)") //description is why we need this expectation
        var result: T.Output?
        let token = publisher //subbing to publisher
            .dropFirst() //drops first published item because we don't needed it, as that would be the initial state
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
