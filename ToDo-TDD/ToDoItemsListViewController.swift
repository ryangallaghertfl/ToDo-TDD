//
//  ToDoItemsListViewController.swift
//  ToDo-TDD
//
//  Created by Ryan Gallagher on 19/11/2023.
//

import UIKit

class ToDoItemsListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var toDoItemStore: ToDoItemStoreProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
    
}

//MARK: extending to conform to UITableViewDataSource

extension ToDoItemsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {return 1}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        return UITableViewCell()
    }
}
