import Foundation
import Combine

class HomeViewModel {
    var datasource: [Counter] = []
    var filteredSearchResults: [Counter] = []
    var selectedCounters: Set<Counter> = []
    
    private(set) var dataChanged = PassthroughSubject<Void, Never>()

    @Published
    var isLoading = false
    
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
    
    func deleteSelectedCounters() {
        selectedCounters.forEach { counter in
            deleteCounter(counter: counter)
        }
    
        self.datasource.removeAll { (counter) -> Bool in
            selectedCounters.contains(counter)
        }
        selectedCounters.removeAll()
        filteredSearchResults = datasource
    }
    
    func deleteCounter(counter: Counter) {
        let countersPub = api.deleteCounterPublisher(id: counter.id)
            .catch { error -> AnyPublisher<[Counter], Never> in
                print("Error Deleting counter: \(error)")
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
                self.dataChanged.send()
            })
            .store(in: &cancellables)
    }
    
    func selectAllCounters() {
        selectedCounters = Set(datasource)
    }
    
    func updateCounterValue(counter: Counter, newValue: Int) {
        if newValue > 0 {
            let countersPub = api.increaseCounterPublisher(id: counter.id)
                .catch { error -> AnyPublisher<[Counter], Never> in
                    print("Error saving counter: \(error)")
                    return Just([]).eraseToAnyPublisher()
                }
                .eraseToAnyPublisher()

            countersPub
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: {
                    self.isLoading = false
                    self.datasource = $0
                    self.filteredSearchResults = $0
                    self.dataChanged.send()
                })
                .store(in: &cancellables)
        
        } else {
            let countersPub = api.decreaseCounterPublisher(id: counter.id)
                .catch { error -> AnyPublisher<[Counter], Never> in
                    print("Error saving counter: \(error)")
                    return Just([]).eraseToAnyPublisher()
                }
                .eraseToAnyPublisher()

            countersPub
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: {
                    self.isLoading = false
                    self.datasource = $0
                    self.filteredSearchResults = $0
                    self.dataChanged.send()
                })
                .store(in: &cancellables)
        }
    }
    
    func filterCounters(text: String) {
        guard !text.isEmpty else {
            filteredSearchResults = datasource
            return
        }
        
        filteredSearchResults = datasource.filter({ (counter) -> Bool in
            counter.title.lowercased().contains(text.lowercased())
        })
    }
    
    func toggleCounterSelection(counter: Counter) {
        if selectedCounters.contains(counter) {
            selectedCounters.remove(counter)
        } else {
            selectedCounters.insert(counter)
        }
    }
    
//    func loadData(completion: @escaping  () -> ()) {
////        datasource = (0...9).map {
////            Counter(id: $0, title: "In a storyboard-based application, you will often want to do a little preparation before navigation \($0)", value: $0)
////        }
////
////        filteredSearchResults = datasource
////        completion()
//    }
    
    func fetchData() {
        isLoading = true
        let countersPub = api.countersPublisher()
            .catch { error -> AnyPublisher<[Counter], Never> in
                print("Error loading counters: \(error)")
                return Just([]).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
        
        countersPub
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {
                self.isLoading = false
                self.datasource = $0
                self.filteredSearchResults = $0
                self.dataChanged.send()
            })
            .store(in: &cancellables)
    }
}



