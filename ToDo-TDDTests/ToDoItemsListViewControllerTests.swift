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

    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = try XCTUnwrap(
        storyboard.instantiateInitialViewController() as? ToDoItemsListViewController)
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

}
