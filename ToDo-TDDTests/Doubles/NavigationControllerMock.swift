//
//  NavigationControllerMock.swift
//  ToDo-TDDTests
//
//  Created by Ryan Gallagher on 24/11/2023.
//

import UIKit

class NavigationControllerMock: UINavigationController {
    var lastPushedViewController: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        lastPushedViewController = viewController
        super.pushViewController(viewController, animated: animated)
    }
}
