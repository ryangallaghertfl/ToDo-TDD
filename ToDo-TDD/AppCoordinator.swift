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
    
    let toDoItemStore: ToDoItemStore
    
    init(window: UIWindow?, navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
        self.window = window
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "ToDoItemsListViewController")
        toDoItemStore = ToDoItemStore()
        }
    
    func start() {
        navigationController.pushViewController(viewController, animated: false)
        window?.rootViewController = navigationController
        if let listViewController = viewController as? ToDoItemsListViewController {
            listViewController.delegate = self
            listViewController.toDoItemStore = toDoItemStore
        }
    }
}

//MARK: conforming to ToDoItemListViewControllerProtocol
extension AppCoordinator: ToDoItemsListViewControllerProtocol {
    func selectToDoItem(_ viewController: UIViewController, item: ToDoItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let next = storyboard.instantiateViewController(withIdentifier: "ToDoItemDetailsViewController") as? ToDoItemDetailsViewController else {
            return
        }
        
        next.loadViewIfNeeded()
        next.toDoItem = item
        next.toDoItemStore = toDoItemStore
        
        navigationController.pushViewController(next, animated: true)
    }
    
    func addToDoItem(_ viewController: UIViewController) {
    }
    
}
