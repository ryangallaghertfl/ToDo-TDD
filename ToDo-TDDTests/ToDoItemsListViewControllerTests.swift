//
//  ToDoItemsListViewControllerTests.swift
//  ToDo-TDDTests
//
//  Created by Ryan Gallagher on 19/11/2023.
//

import XCTest
@testable import ToDo_TDD

final class ToDoItemsListViewControllerTests: XCTestCase {
    
    var sut: ToDoItemsListViewController!
    var toDoItemStoreMock: ToDoItemStoreProtocolMock!

    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = try XCTUnwrap(
        storyboard.instantiateInitialViewController() as? ToDoItemsListViewController)
        toDoItemStoreMock = ToDoItemStoreProtocolMock()
        sut.toDoItemStore = toDoItemStoreMock
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_ToDoItemsListVC_shouldLoadFromStoryBoard_VCShouldBeSetup() {
        XCTAssertNotNil(sut)
    }
    
    func test_ToDoItemsListVC_shouldHaveTableViewForToDoItems() {
        //checks that the tableview is a descendant of parent view
        XCTAssertTrue(sut.tableView.isDescendant(of: sut.view))
    }
    
    func test_ToDoItemsListVC_GivenNumberOfRows_whenOneItemIsSent_shouldReturnOne()
    {
        toDoItemStoreMock.itemPublisher.send([ToDoItem(title: "dummy 1")])
        //should be 1 row in section 0
        let result = sut.tableView.numberOfRows(inSection: 0)
        XCTAssertEqual(result, 1)
    }
    
    func test_ToDoItemsListVC_GivenNumberOfRows_whenTwoItemsAreSent_shouldReturnTwo()
    {
        toDoItemStoreMock.itemPublisher.send([ToDoItem(title: "dummy 1"), ToDoItem(title: "dummy 2")])
        let result = sut.tableView.numberOfRows(inSection: 0)
        XCTAssertEqual(result, 2)
    }

}
