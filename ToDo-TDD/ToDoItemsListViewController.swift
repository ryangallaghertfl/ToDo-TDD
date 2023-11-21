//
//  ToDoItemsListViewController.swift
//  ToDo-TDD
//
//  Created by Ryan Gallagher on 19/11/2023.
//

import UIKit
import Combine

class ToDoItemsListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    var toDoItemStore: ToDoItemStoreProtocol?
    private var items: [ToDoItem] = [] //holds items sent by item publisher
    private var token: AnyCancellable? //holds ref to subscriber subscribed by the publisher
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        
        //subscribe to changes sent by the item publisher of toDoItemStore
        token = toDoItemStore?.itemPublisher
        .sink(receiveValue: { [weak self] items in
        self?.items = items //store items in our array
        })
    }
    
}

//MARK: extending to conform to UITableViewDataSource

extension ToDoItemsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = ToDoItemCell()
        cell.titleLabel.text = "dummy 1"
        return cell
    }
}
