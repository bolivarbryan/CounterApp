import Foundation
import Combine

class HomeViewModel {
    var datasource: [Counter] = []
    var filteredSearchResults: [Counter] = []
    var selectedCounters: Set<Counter> = []
    var searchText: String = ""
    private(set) var dataChanged = PassthroughSubject<Void, Never>()
    private(set) var dataUpdated = PassthroughSubject<Void, Never>()
    
    enum NetworkErrorType {
        case alert
        case alertDeletion
        case emptyState
        case none
    }
    
    @Published
    var isLoading = false
    
    @Published
    var networkError: NetworkErrorType = .none
    
    @Published
    var emptyState: Bool = false
    
    var error: Error?
    
    private let api = CounterAPI()
    private var cancellables = Set<AnyCancellable>()
    
    var numberOfCounters: Int {
        filteredSearchResults.count
    }
    
    var totalCount: Int {
        filteredSearchResults
            .map(\.count)
            .reduce(0, +)
    }
    
    var countersWithQuantity: [String] {
        return Array<Counter>(selectedCounters).map {
            "\($0.count) x \($0.title)"
        }
    }
    
    func filterCounters(text: String) {
        searchText = text
        guard !searchText.isEmpty else {
            filteredSearchResults = datasource
            return
        }
        
        filteredSearchResults = datasource.filter({ (counter) -> Bool in
            counter.title.lowercased().contains(searchText.lowercased())
        })
    }
    
    func toggleCounterSelection(counter: Counter) {
        if selectedCounters.contains(counter) {
            selectedCounters.remove(counter)
        } else {
            selectedCounters.insert(counter)
        }
    }
    
    func selectAllCounters() {
        selectedCounters = Set(datasource)
    }
    
    func deleteSelectedCounters() {
        selectedCounters.forEach { counter in
            deleteCounter(counter: counter)
        }
    }
    
    func performCompletion(networkError: NetworkErrorType) {
        if (self.error != nil) {
            self.networkError = networkError
        } else {
            self.dataChanged.send()
            self.emptyState = self.datasource.count == 0
            self.networkError = .none
        }
    }

    
    func deleteCounter(counter: Counter) {
        let countersPub = api.deleteCounterPublisher(id: counter.id)
            .catch { error -> AnyPublisher<[Counter], Never> in
                print("Error Deleting counter: \(error)")
                self.error = error
                return Just([]).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()

        countersPub
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {
                self.isLoading = false
                self.datasource = $0
                self.filteredSearchResults = $0
                self.selectedCounters.remove(counter)
                self.performCompletion(networkError: .alertDeletion)
            })
            .store(in: &cancellables)
    }
    
    func updateCounterValue(counter: Counter, newValue: Int) {
        let countersPub = api.updateCounterPublisher(id: counter.id, value: newValue)
            .catch { error -> AnyPublisher<[Counter], Never> in
                print("Error saving counter: \(error)")
                self.error = error
                return Just([]).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()

        countersPub
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {
                self.isLoading = false
                self.datasource = $0
                self.filterCounters(text: self.searchText)
                
                self.performCompletion(networkError: .alert)
      
            })
            .store(in: &cancellables)
    }
    
    func fetchData() {
        error = nil
        isLoading = true
        let countersPub = api.countersPublisher()
            .catch { error -> AnyPublisher<[Counter], Never> in
                print("Error loading counters: \(error)")
                self.error = error
                return Just([]).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
        
        countersPub
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {
                self.isLoading = false
                self.datasource = $0
                self.filteredSearchResults = $0
                self.performCompletion(networkError: .emptyState)
            })
            .store(in: &cancellables)
    }
}



