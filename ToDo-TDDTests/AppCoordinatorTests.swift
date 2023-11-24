//
//  AppCoordinatorTests.swift
//  ToDo-TDDTests
//
//  Created by Ryan Gallagher on 24/11/2023.
//

import XCTest
import SwiftUI
@testable import ToDo_TDD

final class AppCoordinatorTests: XCTestCase {
    var sut: AppCoordinator!
    var navigationControllerMock: NavigationControllerMock!
    var window: UIWindow!

    override func setUpWithError() throws {
        // we create a dummy window and an instance of NavigationControllerMock, and use both to initialise an instance of AppCoordinator
        window = UIWindow(frame: CGRect(x: 0,
                                        y: 0,
                                        width: 200,
                                        height: 200))

        navigationControllerMock = NavigationControllerMock()
        sut = AppCoordinator(window: window, navigationController: navigationControllerMock, toDoItemStore: ToDoItemStore(fileName: "dummy_store"))
    }

    override func tearDownWithError() throws {
        sut = nil
        navigationControllerMock = nil
        window = nil
        let url = FileManager.default.documentsURL(name: "dummy_store")
        try? FileManager.default.removeItem(at: url)
    }
    
    func test_AppCoordinator_start_shouldSetDelegate_memoryRefIsSame() throws {
        sut.start()
        let listViewController = try XCTUnwrap(navigationControllerMock.lastPushedViewController as? ToDoItemsListViewController)
        XCTAssertIdentical(listViewController.delegate as? AppCoordinator,
        sut)
    }
    
    func test_AppCoordinator_start_shouldAssignItemStore() throws {
        sut.start()
        let listViewController = try XCTUnwrap(navigationControllerMock.lastPushedViewController as? ToDoItemsListViewController)
        XCTAssertNotNil(listViewController.toDoItemStore)
    }
    
    func test_AppCoordinator_selectToDoItem_pushesDetails() throws {
        let dummyViewController = UIViewController()
        let item = ToDoItem(title: "dummy title")
        
        //execute the delegate method and assert that an instance of ToDoItemDetailsViewController is pushed to the navigation stack and toDoItem matches that used in delegate method call
        sut.selectToDoItem(dummyViewController, item: item)
        
        let detail = try XCTUnwrap(navigationControllerMock.lastPushedViewController
        as? ToDoItemDetailsViewController)
        XCTAssertEqual(detail.toDoItem, item)
    }
    
    func test_AppCoordinator_selectToDoItem_shouldSetItemStore() throws {
        let dummyViewController = UIViewController()
        let item = ToDoItem(title: "dummy title")
        
        sut.selectToDoItem(dummyViewController, item: item)
        let detail = try XCTUnwrap(navigationControllerMock.lastPushedViewController as? ToDoItemDetailsViewController)
        XCTAssertIdentical(detail.toDoItemStore as? ToDoItemStore, sut.toDoItemStore)
    }
    
    func test_AppCoordinator_addToDoItem_shouldPresentInputView() throws {
        let viewControllerMock = ViewControllerMock()

        sut.addToDoItem(viewControllerMock)

        let lastPresented = try XCTUnwrap(viewControllerMock.lastPresented as? UIHostingController<ToDoItemInputView>)
        //asserts that the sut variable is assigned as the delegate of the presented instance of ToDoItemInputView
        XCTAssertIdentical(lastPresented.rootView.delegate as? AppCoordinator, sut)
    }
    
    func test_AppCoordinator_addToDoItemWith_shouldCallToDoItemStore() throws {
       let toDoItemData = ToDoItemData()
       toDoItemData.title = "dummy title"

       let receivedItems = try wait(for: sut.toDoItemStore.itemPublisher, afterChange: {
         sut.addToDoItem(with: toDoItemData, coordinate: nil)
       })
// after calling addToDoItem(with:coordinate:), now itemPublisher of the toDoItemStore property publishes the change to the stored items.
       XCTAssertEqual(receivedItems.first?.title, toDoItemData.title)
     }

}
