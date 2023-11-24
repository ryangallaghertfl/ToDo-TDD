//
//  AppCoordinator.swift
//  ToDo-TDD
//
//  Created by Ryan Gallagher on 24/11/2023.
//

import UIKit

//MARK: Define Coordinator protocol
protocol Coordinator {
    func start()
}

//MARK: implementing class

class AppCoordinator: Coordinator {
    private let window: UIWindow?
    private let viewController: UIViewController
    
    init(window: UIWindow?) {
        self.window = window
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "ToDoItemsListViewController")
        }
    
    func start() {
        window?.rootViewController = viewController
    }
}
