//
//  Counter.swift
//  Counters
//
//  Created by Bryan Bolivar on 10/08/20.
//

import Foundation

class Counter: Equatable, Codable, Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Counter, rhs: Counter) -> Bool {
        lhs.title == rhs.title
    }
    
    var id: String
    var title: String
    var count: Int
    
//    init(id: String, title: String = "", value: Int = 0) {
//        self.id = id
//        self.title = title
//        self.value = value
//    }
}
