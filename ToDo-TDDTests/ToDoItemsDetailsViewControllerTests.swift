//
//  ToDoItemsDetailsViewControllerTests.swift
//  ToDo-TDDTests
//
//  Created by Ryan Gallagher on 22/11/2023.
//

import XCTest
@testable import ToDo_TDD

final class ToDoItemsDetailsViewControllerTests: XCTestCase {
    
    var sut: ToDoItemDetailsViewController!
    
    override func setUpWithError() throws {
        
        let storyboard = UIStoryboard(name: "Main", bundle:nil)
        sut = (storyboard.instantiateViewController(withIdentifier: "ToDoItemDetailsViewController") as! ToDoItemDetailsViewController)
        sut.loadViewIfNeeded()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_ToDoItemsDetailsVC_view_shouldHaveTitleLabel_assetsTruel() throws {
        let subview = try XCTUnwrap(sut.titleLabel)
        XCTAssertTrue(subview.isDescendant(of: sut.view))
    }
}

