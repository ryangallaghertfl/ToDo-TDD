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
    
    func test_ToDoItemDetailsVC_view_shouldHaveTitleLabel_assertsTruel() throws {
        let subview = try XCTUnwrap(sut.titleLabel)
        XCTAssertTrue(subview.isDescendant(of: sut.view))
    }
    
    func test__ToDoItemDetailsVC_view_shouldHaveDateLabel_assertsTrue() throws {
        let subview = try XCTUnwrap(sut.dateLabel)
        XCTAssertTrue(subview.isDescendant(of: sut.view))
    }
    
    func test_ToDoItemDetailsVC_view_shouldHaveLocationLabel_assertsTrue() throws {
        let subview = try XCTUnwrap(sut.locationLabel)
        XCTAssertTrue(subview.isDescendant(of: sut.view))
    }
    
    func test_ToDoItemDetailsVC_view_shouldHaveDescriptionLabel_assertsTrue() throws {
        let subview = try XCTUnwrap(sut.descriptionLabel)
        XCTAssertTrue(subview.isDescendant(of: sut.view))
    }
    
    func test_ToDoItemDetailsVC_view_shouldHaveMapView_assertsTrue() throws {
        let subview = try XCTUnwrap(sut.mapView)
        XCTAssertTrue(subview.isDescendant(of: sut.view))
    }
    
    func test_ToDoItemDetailsVC_view_shouldHaveDoneButton_assertsTrue() throws {
        let subview = try XCTUnwrap(sut.doneButton)
        XCTAssertTrue(subview.isDescendant(of: sut.view))
    }
    
    func test_ToDoItemDetailsVC_settingToDoItem_shouldUpdateTitleLabel_assertsTrue() {
        let title = "dummy title"
        let toDoItem = ToDoItem(title: title)
        sut.toDoItem = toDoItem
        XCTAssertEqual(sut.titleLabel.text, title)
    }
    
    func test_ToDoItemDetailsVC_settingToDoItem_shouldUpdateDateLabel_assertsTrue() {
        let date = Date()
        let toDoItem = ToDoItem(title: "dummy title", timestamp: date.timeIntervalSince1970)
        sut.toDoItem = toDoItem
        XCTAssertEqual(sut.dateLabel.text, sut.dateFormatter.string(from: date))
    }
    
    func test_ToDoItemDetailsVC_settingToDoItem_shouldUpdateDescriptionLabel_assertsTrue() 
    {
        let description = "dummy discription"
        let toDoItem = ToDoItem(title: "dummy title", itemDescription: description)
        sut.toDoItem = toDoItem
        XCTAssertEqual(sut.descriptionLabel.text, description)
    }
    
    func test_ToDoItemDetailsVC_settingToDoItem_shouldUpdateLocationLabel_assertsTrue() {
        let location = "dummy location"
        let toDoItem = ToDoItem( title: "dummy title", location: Location(name: location))
        sut.toDoItem = toDoItem
        XCTAssertEqual(sut.locationLabel.text, location)
    }
    
    func test_ToDoItemDetailsVC_settingToDoItem_shouldUpdateMapView_assertsTrue() {
        let latitude = 51.225556
        let longitude = 6.782778
        let toDoItem = ToDoItem(title: "dummy title", location: Location(name: "dummy location", coordinate: Coordinate(latitude: latitude, longitude: longitude)))
        sut.toDoItem = toDoItem
        let center = sut.mapView.centerCoordinate
        XCTAssertEqual(center.latitude, latitude, accuracy: 0.000_01)
        XCTAssertEqual(center.longitude, longitude, accuracy: 0.000_01)
    }
    
    func test_ToDoItemDetailsVC_settingToDoItem_shouldUpdateButtonState_assertsFalse() {
        var toDoItem = ToDoItem(title: "dummy title")
        toDoItem.done = true
        sut.toDoItem = toDoItem
        XCTAssertFalse(sut.doneButton.isEnabled)
    }
    
    func test_ToDoItemDetailsVC_settingToDoItem_whenItemNotDone_shouldUpdateButtonState_assertTrue() {
        let toDoItem = ToDoItem(title: "dummy title")
        sut.toDoItem = toDoItem
        XCTAssertTrue(sut.doneButton.isEnabled)
    }
    
}

