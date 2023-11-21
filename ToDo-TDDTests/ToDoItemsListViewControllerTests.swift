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
    
    func test_ToDoItemsListVC_cellForRowAt_shouldReturnCellWithTitle_Asserts_Equal() throws
    {
        let titleUnderTest = "dummy 1"
        //publish a list with one to-do item using our test double
        toDoItemStoreMock.itemPublisher.send([ToDoItem(title: titleUnderTest)])
        let tableView = try XCTUnwrap(sut.tableView)
        
        let indexPath = IndexPath(row: 0, section: 0)
        //execute the tableView(_:cellForRowAt:) method
        //returned table view cell should have a label showing the title of the to-do item sent by the publisher
        let cell = try XCTUnwrap(tableView.dataSource?.tableView(tableView, cellForRowAt: indexPath) as? ToDoItemCell)
        
        XCTAssertEqual(cell.titleLabel.text, titleUnderTest)
    }
    
    func test_ToDoItemsListVC_cellForRowAt_Sends2ToDoItems_shouldReturnSecondCellWithTitle_AssertsEqual()
    throws
    {
        let titleUnderTest = "dummy 2"
        toDoItemStoreMock.itemPublisher.send([ToDoItem(title: "dummy 1"), ToDoItem(title: titleUnderTest)])
        let tableView = try XCTUnwrap(sut.tableView)
        let indexPath = IndexPath(row: 1, section: 0)
        let cell = try XCTUnwrap(
            tableView.dataSource?.tableView(tableView,cellForRowAt: indexPath) as? ToDoItemCell)
        
        XCTAssertEqual(cell.titleLabel.text, titleUnderTest)
    }
    
    func test_ToDoItemsListVC_cellForRowAt_shouldReturnCellWithDate_AssertsTrue() throws {
        let date = Date()
        toDoItemStoreMock.itemPublisher.send([ToDoItem(title: "dummy 1", timestamp: date.timeIntervalSince1970)])
        
        let tableView = try XCTUnwrap(sut.tableView)
        
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = try XCTUnwrap(
            tableView.dataSource?.tableView(tableView, cellForRowAt: indexPath) as? ToDoItemCell)
    
        XCTAssertEqual(cell.dateLabel.text, sut.dateFormatter.string(from: date))
    }

}
