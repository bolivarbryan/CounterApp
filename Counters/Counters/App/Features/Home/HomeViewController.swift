//
//  HomeViewController.swift
//  Counters
//
//  Created by Bryan Bolivar on 10/08/20.
//

import UIKit
import Components

class HomeViewController: UIViewController {
    
    var datasource: [Counter] = [
        Counter(id: 0, title: "Push ups", value: 100),
        Counter(id: 1, title: "Water plants"),
        Counter(id: 2, title: "Visited Clients"),
        Counter(id: 3, title: "Visited Clients", value: 999),
        Counter(id: 4, title: "Visited Clients"),
        Counter(id: 5, title: "Visited Clients", value: 70),
        Counter(id: 6, title: "Visited Clients"),
        Counter(id: 7, title: "Water plants"),
        Counter(id: 8, title: "Visited Clients"),
        Counter(id: 9, title: "Visited Clients"),
        Counter(id: 10, title: "Visited Clients"),
        Counter(id: 11, title: "Visited Clients"),
        Counter(id: 12, title: "Visited Clients")
    ]
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var toolBar: CounterToolBar! {
        didSet {
            toolBar.tintColor = UIColor.Pallete.tintColor
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Counters"
        configureNavigationBar()
        configureToolBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
      
    }

    func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = UIColor.Pallete.tintColor
    }
    
    func configureToolBar() {
        toolBar.state = .titleWithAdd(count: 5, total: 15)
    }
    
    func configureEmptyState() {
        let emptyStateView = EmptyStateViewController(nibName: "EmptyStateView",
                                                      bundle: nil)
                                                      
        emptyStateView.view.backgroundColor = UIColor.Pallete.gray230
        emptyStateView.delegate = self
        tableView.addSubview(emptyStateView.view)
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID") as! CounterTableViewCell
        cell.counter = datasource[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}

extension HomeViewController: EmptyStateDelegate {
    func didSelectActionButton() {
        
    }
    
    var titleLabel: String {
        return "No counters yet"
    }
    
    var descriptionLabel: String {
        return "“When I started counting my blessings, my whole life turned around.”\n—Willie Nelson"
    }
    
    var actionButtonTitle: String {
        return "Create a counter"
    }
    
}


extension HomeViewController: CounterTableViewCellDelegate {
    func counterValueDidUpdate(counter: Counter) {
        print(counter)
        
        datasource[counter.id] = counter
    }
    
}
