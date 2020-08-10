//
//  HomeViewController.swift
//  Counters
//
//  Created by Bryan Bolivar on 10/08/20.
//

import UIKit
import Components

class HomeViewController: UIViewController {
    
    let datasource: [Counter] = [
        Counter(title: "Push ups"),
        Counter(title: "Water plants"),
        Counter(title: "Visited Clients")
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

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID")
        cell?.textLabel?.text = datasource[indexPath.row].title
        cell?.detailTextLabel?.text = String(datasource[indexPath.row].value)
        return cell!
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


