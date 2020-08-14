import Foundation
import Combine

class AddCounterViewModel {
    
    private(set) var dataChanged = PassthroughSubject<Void, Never>()

    @Published
    var isLoading = false
    
    @Published
    var networkError: Bool = false
    
    var error: Error?
    
    private let api = CounterAPI()
    private var cancellables = Set<AnyCancellable>()
    
    func saveCounter(title: String) {
        let countersPub = api.createCounterPublisher(title: title)
            .catch { error -> AnyPublisher<[Counter], Never> in
                print("Error Deleting counter: \(error)")
                self.error = error
                return Just([]).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()

        countersPub
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { _ in
                self.isLoading = false
                if self.error == nil {
                    self.dataChanged.send()
                } else {
                    self.networkError = true
                }
            })
            .store(in: &cancellables)
    }
}
