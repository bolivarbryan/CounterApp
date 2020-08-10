//
//  Counter.swift
//  Counters
//
//  Created by Bryan Bolivar on 10/08/20.
//

import Foundation

class Counter {
    var title: String
    var value: Int
    
    init(title: String = "", value: Int = 0) {
        self.title = title
        self.value = value
    }
}
