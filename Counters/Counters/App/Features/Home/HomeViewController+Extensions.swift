import Foundation
import UIKit
import Components

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
        valueToUpdateCounter = newValue
        counterToUpdate = counter
        viewModel.updateCounterValue(counter: counter, newValue: valueToUpdateCounter)
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
        shareCounters()
    }
}

//MARK: - Alert Actions
extension HomeViewController {
    func presentActionSheetForDelete() {
        navigationItem.leftBarButtonItem?.isEnabled = false
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "Delete \(viewModel.selectedCounters.count) Counters", style: .default) { _ in
            self.viewModel.deleteSelectedCounters()
        }
        
        actionSheet.addAction(action)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.view.tintColor = UIColor.Pallete.tintColor
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func presentNetworkErrorAlert() {
        var title: String = ""
        
        if state == .networkErrorAlert {
            title = Language.Main.errorUpdatingValue.localizedValue + " to 1"
        } else if state == .networkErrorAlertDeletion {
            title = "Couldn’t delete the counter “\(self.counterToUpdate?.title ?? "")”"
        }
        
        let errorMessage = Language.Main.errorInternetConnection.localizedValue
        let actionSheet = UIAlertController(title: title, message: errorMessage, preferredStyle: .alert)
        
        let action = UIAlertAction(title: Language.Main.retry.localizedValue, style: .default) { _ in
            guard let counter = self.counterToUpdate else { return }
            if self.state == .networkErrorAlert {
                self.viewModel.updateCounterValue(counter: counter, newValue: self.valueToUpdateCounter)
            } else if self.state == .networkErrorAlertDeletion {
                self.viewModel.deleteCounter(counter: counter)
            }
        }
        
        actionSheet.addAction(action)
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in
            self.state = .networkError
        })
        
        actionSheet.view.tintColor = UIColor.Pallete.tintColor
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    
    func shareCounters() {
        let ac = UIActivityViewController(activityItems: viewModel.countersWithQuantity, applicationActivities: nil)
        present(ac, animated: true)
    }
}
