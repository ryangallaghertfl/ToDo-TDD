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
    let dateFormatter = DateFormatter()
    
    private var dataSource: UITableViewDiffableDataSource<Section, ToDoItem>?
    
    var delegate: ToDoItemsListViewControllerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //we initialise a diffable data source for the table view.
        dataSource = UITableViewDiffableDataSource<Section, ToDoItem>(tableView: tableView, cellProvider: { [weak self] tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath) as! ToDoItemCell
            cell.titleLabel.text = item.title
            
            if let timestamp = item.timestamp {
                let date = Date(timeIntervalSince1970: timestamp)
                cell.dateLabel.text = self?.dateFormatter.string(from: date)
            }
            return cell
            })
        
        //cell reuse capability for performance
        tableView.register(ToDoItemCell.self, forCellReuseIdentifier: "ToDoItemCell")
        
        //subscribe to changes sent by the item publisher of toDoItemStore
        token = toDoItemStore?.itemPublisher
        .sink(receiveValue: { [weak self] items in
        self?.items = items //store items in our array
        self?.update(with: items) //call update method with new snapshot of data source
        })
        tableView.delegate = self
    }
    
    private func update(with items: [ToDoItem]) {
        //UITableViewDiffableDataSource manages table view updates via NSDiffableDataSourceSnapshot
        var snapshot = NSDiffableDataSourceSnapshot<Section, ToDoItem>()
        //to update the table view with new data, we need to create a snapshot and set it up with the new data
        snapshot.appendSections([.todo, .done])
        snapshot.appendItems(items.filter({ false == $0.done }), toSection: .todo)
        snapshot.appendItems(items.filter({ $0.done }), toSection: .done)
        dataSource?.apply(snapshot)
    }
    
    enum Section {
        case todo
        case done
    }
    
}

//MARK: extends ToDoITemsListViewController to conforms to UITableViewDelegate

extension ToDoItemsListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = items[indexPath.row]
        
        delegate?.selectToDoItem(self, item: item)
    }
}

//MARK: create protocol for handling mocks
protocol ToDoItemsListViewControllerProtocol {
    
    func selectToDoItem(_ viewController: UIViewController, item: ToDoItem)
}
