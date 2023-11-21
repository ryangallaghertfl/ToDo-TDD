//
//  toDoItemCellTests.swift
//  ToDo-TDDTests
//
//  Created by Ryan Gallagher on 21/11/2023.
//

import XCTest
@testable import ToDo_TDD

final class toDoItemCellTests: XCTestCase {
    
    var sut: ToDoItemCell!

    override func setUpWithError() throws {
        sut = ToDoItemCell()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_ToDoItemCell_ShouldHaveTitleLabelSubview_ReturnsTrue() {
        let subview = sut.titleLabel
        XCTAssertTrue(subview.isDescendant(of: sut.contentView))
        
    }
    
    func test_ToDoItemListVC_ShouldhaveDateLabelSubview() {
        let subview = sut.dateLabel
        XCTAssertTrue(subview.isDescendant(of: sut.contentView))
    }

}
