//
//  AppCoordinatorTests.swift
//  ToDo-TDDTests
//
//  Created by Ryan Gallagher on 24/11/2023.
//

import XCTest
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
        sut = AppCoordinator(window: window, navigationController: navigationControllerMock)
    }

    override func tearDownWithError() throws {
        sut = nil
        navigationControllerMock = nil
        window = nil
    }
    
    func test_AppCoordinator_start_shouldSetDelegate_memoryRefIsSame() throws {
        sut.start()
        let listViewController = try XCTUnwrap(navigationControllerMock.lastPushedViewController as? ToDoItemsListViewController)
        XCTAssertIdentical(listViewController.delegate as? AppCoordinator,
        sut)
    }
    
    func test_start_shouldAssignItemStore() throws {
        sut.start()
        let listViewController = try XCTUnwrap(navigationControllerMock.lastPushedViewController as? ToDoItemsListViewController)
        XCTAssertNotNil(listViewController.toDoItemStore)
        
    }


}
