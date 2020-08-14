import Foundation

class HomeViewModel {
    var datasource: [Counter] = []
    var filteredSearchResults: [Counter] = []
    
    var selectedCounters: Set<Counter> = []
    
    var numberOfCounters: Int {
        filteredSearchResults.count
    }
    
    var totalCount: Int {
        filteredSearchResults
            .map(\.value)
            .reduce(0, +)
    }
    
    func deleteSelectedCounters() {
        self.datasource.removeAll { (counter) -> Bool in
            selectedCounters.contains(counter)
        }
        selectedCounters.removeAll()
        filteredSearchResults = datasource
    }
    
    func selectAllCounters() {
        selectedCounters = Set(datasource)
    }
    
    func updateCounterValue(counter: Counter) {
        guard let index = datasource.firstIndex(of: counter) else {
            return
        }
        datasource[index].value = counter.value
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
        print(selectedCounters.map(\.id))
    }
    
    func loadData(completion: @escaping  () -> ()) {
        datasource = (0...9).map {
            Counter(id: $0, title: "Item \($0)", value: $0)
        }
                
        filteredSearchResults = datasource
        completion()
    }
    
}
