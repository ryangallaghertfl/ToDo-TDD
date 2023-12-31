//
//  AppSetupTests.swift
//  ToDo-TDDTests
//
//  Created by Ryan Gallagher on 24/11/2023.
//

import XCTest
@testable import ToDo_TDD

final class AppSetupTests: XCTestCase {

    func test_application_rootVC_shouldBeToDoItemsListViewController() throws {
        let application = UIApplication.shared
        let scene = application.connectedScenes.first as? UIWindowScene
        let root = scene?.windows.first?.rootViewController
        let nav = try XCTUnwrap(root as? UINavigationController)
        XCTAssert(nav.topViewController is ToDoItemsListViewController)
    }

}
