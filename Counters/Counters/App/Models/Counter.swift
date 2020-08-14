//
//  Counter.swift
//  Counters
//
//  Created by Bryan Bolivar on 10/08/20.
//

import Foundation

class Counter: Equatable, Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Counter, rhs: Counter) -> Bool {
        lhs.title == rhs.title
    }
    
    var id: Int
    var title: String
    var value: Int
    
    init(id: Int, title: String = "", value: Int = 0) {
        self.id = id
        self.title = title
        self.value = value
    }
}
