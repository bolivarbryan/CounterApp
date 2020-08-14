import Foundation
import Combine

struct CounterAPI {
    let baseURL = URL(string: "http://127.0.0.1:3000/api/v1/")!
    let session = URLSession.shared
    
    let decoder: JSONDecoder
    
    init() {
        decoder = JSONDecoder()
    }
    
    func countersPublisher() -> AnyPublisher<[Counter], Error> {
        let url = baseURL.appendingPathComponent("counters")
        return session.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [Counter].self, decoder: decoder)
            .map { $0 }
            .eraseToAnyPublisher()
    }
    
    func increaseCounterPublisher(id: String) -> AnyPublisher<[Counter], Error> {
            let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
            let url = baseURL.appendingPathComponent("counter/inc")
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            let bodyObject: [String : Any] = [
                "id": "\(id)"
            ]
            request.httpBody = try! JSONSerialization.data(withJSONObject: bodyObject, options: [])

        
        return session.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: [Counter].self, decoder: decoder)
            .map { $0 }
            .eraseToAnyPublisher()
    }
    
    func decreaseCounterPublisher(id: String) -> AnyPublisher<[Counter], Error> {
            let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
        let url = baseURL.appendingPathComponent("counter/dec")
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            let bodyObject: [String : Any] = [
                "id": "\(id)"
            ]
            request.httpBody = try! JSONSerialization.data(withJSONObject: bodyObject, options: [])

        
        return session.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: [Counter].self, decoder: decoder)
            .map { $0 }
            .eraseToAnyPublisher()
    }
    
    
    func deleteCounterPublisher(id: String) -> AnyPublisher<[Counter], Error> {
            let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
        let url = baseURL.appendingPathComponent("counter")
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            let bodyObject: [String : Any] = [
                "id": "\(id)"
            ]
            request.httpBody = try! JSONSerialization.data(withJSONObject: bodyObject, options: [])

        return session.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: [Counter].self, decoder: decoder)
            .map { $0 }
            .eraseToAnyPublisher()
    }
    
    
    func createCounterPublisher(title: String) -> AnyPublisher<[Counter], Error> {
            let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
        let url = baseURL.appendingPathComponent("counter")
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            let bodyObject: [String : Any] = [
                "title": "\(title)"
            ]
            request.httpBody = try! JSONSerialization.data(withJSONObject: bodyObject, options: [])

        return session.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: [Counter].self, decoder: decoder)
            .map { $0 }
            .eraseToAnyPublisher()
    }
    
    
}

