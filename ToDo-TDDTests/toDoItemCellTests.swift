//
//  toDoItemCellTests.swift
//  ToDo-TDDTests
//
//  Created by Ryan Gallagher on 21/11/2023.
//

import XCTest
@testable import ToDo_TDD

final class ToDoItemCellTests: XCTestCase {
    
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
    
    func test_ToDoItemCell_ShouldhaveDateLabelSubview_ReturnsTrue() {
        let subview = sut.dateLabel
        XCTAssertTrue(subview.isDescendant(of: sut.contentView))
    }
    
    func test_ToDoItemCell_hasLocationLabelSubview_ReturnsTrue() {
        let subview = sut.locationLabel
        XCTAssertTrue(subview.isDescendant(of: sut.contentView))
    }

}
