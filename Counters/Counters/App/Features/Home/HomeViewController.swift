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
        case networkErrorAlert
        case networkErrorAlertDeletion
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
    var searchController = UISearchController(searchResultsController: nil) {
        didSet {
            searchController.searchResultsUpdater = self
            searchController.obscuresBackgroundDuringPresentation = false
        }
    }
    var valueToUpdateCounter: Int = 0
    var counterToUpdate: Counter?
    
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
        configureSubscribers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        state = .loading
        configureNavigationBar()
        fetchData()
    }
    
    var editBtn: UIBarButtonItem { UIBarButtonItem(title: Language.Main.edit.localizedValue, style: .plain, target: self, action: #selector(changeStateToEdit)) }
    
    var doneBtn: UIBarButtonItem { UIBarButtonItem(title: Language.Main.done.localizedValue, style: .done, target: self, action: #selector(changeStateToNormal)) }
    
    var selectAllBtn: UIBarButtonItem { UIBarButtonItem(title: Language.Main.selectAll.localizedValue, style: .done, target: self, action: #selector(selectAllCounters)) }
    
    //MARK: - Combine Publishers
    
    func configureSubscribers() {
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
                switch networkError {
                case .alert:
                    self?.state = .networkErrorAlert
                case .emptyState:
                    self?.state = .networkError
                case .alertDeletion:
                    self?.state = .networkErrorAlertDeletion
                case .none:
                    break
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
    @objc func fetchData() {
        viewModel.fetchData()
    }
    
    //MARK: - State changes
    
    ///Updates the ui depending of the current state
    func configureScreenForState() {
        resetUI()
        switch state {
        case .emptyState, .networkError:
            navigationItem.leftBarButtonItem = editBtn
            navigationItem.leftBarButtonItem?.isEnabled = false
            
            if state == .emptyState {
                configureForError(title: Language.Main.errorNoCountersYet, body: Language.Main.errorNoCountersYetDescription, action:Language.Main.createACounter)
            } else if state == .networkError {
                configureForError(title: Language.Main.errorLoadingCounters, body: Language.Main.errorInternetConnection, action: Language.Main.retry)
            }

        case .loading:
            navigationItem.leftBarButtonItem = editBtn
            navigationItem.leftBarButtonItem?.isEnabled = false
            activityIndicator.startAnimating()
            toolBar.state = .onlyAdd
            
        case .normal:
            navigationItem.leftBarButtonItem = editBtn
            enableTableView()
            toolBar.state = .titleWithAdd(count: viewModel.numberOfCounters, total: viewModel.totalCount)
            
        case .searching:
            toolBar.state = .titleWithAdd(count: viewModel.numberOfCounters, total: viewModel.totalCount)
            enableTableView()
            
        case .searchWithoutResults:
            configureForError(title: nil, body: Language.Main.searchNoResults, action: nil)
            
        case .editingEnabled:
            navigationItem.leftBarButtonItem =  doneBtn
            navigationItem.rightBarButtonItem =  selectAllBtn
            enableTableView()
            toolBar.state = .deleteAndShare
            
        case .networkErrorAlert, .networkErrorAlertDeletion:
            presentNetworkErrorAlert()
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
    
    func configureForError(title: Localizable? = nil, body: Localizable, action: Localizable? = nil ) {
        emptyStateContainerView.addSubview(emptyStateView.view)
        toolBar.state = .onlyAdd
        emptyStateView.reloadInfo(title: title, body: body, action: action)
    }
    
    func enableTableView() {
        tableView.isHidden = false
        tableView.reloadData()
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
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = UIColor.Pallete.tintColor
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}
