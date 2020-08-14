import Foundation

class AddCounterViewModel {
    
    func saveCounter(title: String, completion: @escaping (Bool) -> ()) {
        let counter = Counter(id: 1000, title: title)
        completion(false)
    }
}
