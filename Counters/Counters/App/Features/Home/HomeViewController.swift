//
//  HomeViewController.swift
//  Counters
//
//  Created by Bryan Bolivar on 10/08/20.
//

import UIKit
import Components
import Combine

class HomeViewController: UIViewController {
    
    ///Describes all the possible scenarios that HomeViewController can have
    enum State {
        case normal
        case editingEnabled
        case emptyState
        case loading
        case networkError
        case searching
        case searchWithoutResults
    }
    
    //MARK: - Properties and UI Components
    
    var state: State = .loading {
        didSet {
            configureScreenForState()
        }
    }
    
    let viewModel: HomeViewModel = HomeViewModel()
    private var cancellables = Set<AnyCancellable>()
    let emptyStateView = EmptyStateViewController(nibName: "EmptyStateView", bundle: nil)
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var emptyStateContainerView: UIView! {
        didSet {
            emptyStateContainerView.addSubview(emptyStateView.view)
            emptyStateView.view.frame = emptyStateContainerView.bounds
            emptyStateView.delegate = self
        }
    }
    @IBOutlet weak var toolBar: CounterToolBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    private let refreshControl = UIRefreshControl()
    
    override var view: UIView! {
        didSet {
            view.backgroundColor = UIColor.systemBackground
        }
    }
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Language.Main.appName.localizedValue
        tableView.contentInset.bottom = 20
        toolBar.toolBarDelegate = self
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        setupPublishers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        state = .loading
        configureNavigationBar()
        fetchData()
    }
    
    var editBtn: UIBarButtonItem {
        UIBarButtonItem(title: Language.Main.edit.localizedValue,
                                                           style: .plain,
                                                           target: self, action: #selector(changeStateToEdit))
    }
    
    var doneBtn: UIBarButtonItem {
        UIBarButtonItem(title: Language.Main.done.localizedValue,
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(changeStateToNormal))
    }
    
    var selectAllBtn: UIBarButtonItem {
        UIBarButtonItem(title: Language.Main.selectAll.localizedValue,
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(selectAllCounters))
    }
    
    //MARK: - Combine Publishers
    
    func setupPublishers() {
        viewModel.$emptyState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] emptyState in
                if emptyState {
                    self?.state = .emptyState
                }
            }
            .store(in: &cancellables)
        
        viewModel.$networkError
            .receive(on: DispatchQueue.main)
            .sink { [weak self] networkError in
                if networkError {
                   self?.state = .networkError
                }
            }
            .store(in: &cancellables)
        
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                if isLoading {
                   self?.state = .loading
                } else {
                    self?.refreshControl.endRefreshing()
                }
            }
            .store(in: &cancellables)
        
       viewModel.dataChanged
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                if self?.searchController.isActive == true {
                    self?.state = .searching
                    self?.tableView.reloadData()
                } else {
                    self?.state = .normal
                }
            }
            .store(in: &cancellables)
        
        viewModel.dataUpdated
             .receive(on: DispatchQueue.main)
             .sink { [weak self] _ in
                self?.state = .editingEnabled
             }
             .store(in: &cancellables)
    }
    
    //MARK: - ViewModel Data Setup
    @objc private func fetchData() {
        viewModel.fetchData()
     }
    
    //MARK: - State changes
    
    ///Updates the ui depending of the current state
    func configureScreenForState() {
        func configureForError(title: Localizable? = nil, body: Localizable, action: Localizable? = nil ) {
            emptyStateContainerView.addSubview(emptyStateView.view)
            toolBar.state = .onlyAdd
            emptyStateView.reloadInfo(title: title, body: body, action: action)
        }
        
        func enableTableView() {
            tableView.isHidden = false
            tableView.reloadData()
        }
        
        resetUI()
        
        switch state {
        case .emptyState, .networkError:
            if state == .emptyState {
                configureForError(title: Language.Main.errorNoCountersYet,
                                  body: Language.Main.errorNoCountersYetDescription,
                                  action:Language.Main.createACounter)
            } else if state == .networkError {
                configureForError(title: Language.Main.errorLoadingCounters,
                                  body: Language.Main.errorInternetConnection,
                                  action: Language.Main.retry)
            }
            navigationItem.leftBarButtonItem = editBtn
            navigationItem.leftBarButtonItem?.isEnabled = false
        case .loading:
            activityIndicator.startAnimating()
            toolBar.state = .onlyAdd
            navigationItem.leftBarButtonItem = editBtn
            navigationItem.leftBarButtonItem?.isEnabled = false
        case .normal:
            enableTableView()
            toolBar.state = .titleWithAdd(count: viewModel.numberOfCounters,
                                          total: viewModel.totalCount)
            
            navigationItem.leftBarButtonItem = editBtn
        case .searching:
            toolBar.state = .titleWithAdd(count: viewModel.numberOfCounters,
                                          total: viewModel.totalCount)
            enableTableView()
            
        case .searchWithoutResults:
            configureForError(title: nil,
                              body: Language.Main.searchNoResults,
                              action: nil)
        case .editingEnabled:
            enableTableView()
            navigationItem.leftBarButtonItem =  doneBtn
            navigationItem.rightBarButtonItem =  selectAllBtn
            toolBar.state = .deleteAndShare
        }

    }
    
    @objc func changeStateToNormal() {
        state = .normal
    }
    
    @objc func changeStateToEdit() {
        viewModel.selectedCounters.removeAll()
        state = .editingEnabled
    }
    
    @objc func selectAllCounters() {
        viewModel.selectAllCounters()
        state = .editingEnabled
    }
    
    ///Resets the components to a default state
    func resetUI() {
        tableView.isHidden = true
        emptyStateView.view.removeFromSuperview()
        activityIndicator.stopAnimating()
        navigationItem.rightBarButtonItem = nil
    }
    
    /// Configures Navigation bar behavior including Search bar controller
    func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        addSearchController(searchController: searchController)
    }
    
    func addSearchController(searchController: UISearchController) {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = UIColor.Pallete.tintColor
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    func presentActionSheetForDelete() {
        navigationItem.leftBarButtonItem?.isEnabled = false
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "Delete \(viewModel.selectedCounters.count) Counters",
                                   style: .default) { _ in
            self.viewModel.deleteSelectedCounters()
        }
        actionSheet.addAction(action)
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler: nil))
        actionSheet.view.tintColor = UIColor.Pallete.tintColor
        self.present(actionSheet, animated: true, completion: nil)
    }
    
}

//MARK: - UITableViewDataSource & UITableViewDelegate
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if state == .searching {
            return viewModel.filteredSearchResults.count
        }
        
        return viewModel.datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID") as! CounterTableViewCell
        let counter = state == .searching ? viewModel.filteredSearchResults[indexPath.row] : viewModel.datasource[indexPath.row]
        cell.counter = counter
        cell.delegate = self
        cell.state = state
        cell.isCounterSelected = viewModel.selectedCounters.contains(counter)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//MARK: - EmptyStateDelegate
extension HomeViewController: EmptyStateDelegate {
    func didSelectActionButton() {
        if state == .networkError {
            state = .loading
            fetchData()
        } else if state == .emptyState {
            didSelectAdd()
        }
    }
}

//MARK: - CounterTableViewCellDelegate
extension HomeViewController: CounterTableViewCellDelegate {    
    func toggleCounterSelection(counter: Counter) {
        viewModel.toggleCounterSelection(counter: counter)
        state = .editingEnabled
    }
    
    func counterValueDidUpdate(counter: Counter, newValue: Int) {
        viewModel.updateCounterValue(counter: counter, newValue: newValue)
    }
}

//MARK: - Search
extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        state = searchController.isActive ? .searching : .normal
        viewModel.filterCounters(text: searchController.searchBar.text ?? "")
        
        if state == .normal &&  viewModel.filteredSearchResults.isEmpty {
            state = .emptyState
        } else if state == .searching  && viewModel.filteredSearchResults.isEmpty {
            state = .searchWithoutResults
        }
        tableView.reloadData()
    }
}


//MARK: - CounterToolBarDelegate
extension HomeViewController: CounterToolBarDelegate {
    func didSelectDelete() {
        presentActionSheetForDelete()
    }
    
    func didSelectAdd() {
        performSegue(withIdentifier: "CreateCounterSegue", sender: self)
    }
    
    func didSelectShare() {
        print("share")
    }
    
    
}
