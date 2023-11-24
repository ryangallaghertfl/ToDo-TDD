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
    private let navigationController: UINavigationController
    
    init(window: UIWindow?, navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
        self.window = window
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "ToDoItemsListViewController")
        }
    
    func start() {
        navigationController.pushViewController(viewController, animated: false)
        window?.rootViewController = navigationController
        if let listViewController = viewController as? ToDoItemsListViewController {
            listViewController.delegate = self
        }
    }
}

//MARK: conforming to ToDoItemListViewControllerProtocol
extension AppCoordinator: ToDoItemsListViewControllerProtocol {
    func selectToDoItem(_ viewController: UIViewController, item: ToDoItem) {
    }
    
}
