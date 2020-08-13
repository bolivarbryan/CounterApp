//
//  Counter.swift
//  Counters
//
//  Created by Bryan Bolivar on 10/08/20.
//

import Foundation

class Counter {
    var id: Int
    var title: String
    var value: Int
    
    init(id: Int, title: String = "", value: Int = 0) {
        self.id = id
        self.title = title
        self.value = value
    }
}
