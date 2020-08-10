//
//  CounterToolBar.swift
//  Counters
//
//  Created by Bryan Bolivar on 10/08/20.
//

import Foundation
import UIKit
import Components

class CounterToolBar: UIToolbar {
    enum State {
        case deleteAndShare
        case onlyAdd
        case titleWithAdd(count: Int, total: Int)
        case empty
    }
    
    lazy var flexibleSpace = UIBarButtonItem(systemItem: .flexibleSpace, primaryAction: nil, menu: nil)
    lazy var addItem = UIBarButtonItem(image: Image.plus.imageRepresentation,
                               style: .plain,
                               target: self,
                               action: nil)
    
    var state: State  = .empty {
        didSet {
            
            switch state {
            case .deleteAndShare:
                let deleteItem = UIBarButtonItem(image: Image.trash.imageRepresentation,
                                           style: .plain,
                                           target: self,
                                           action: nil)
                
                let shareItem = UIBarButtonItem(image: Image.share.imageRepresentation,
                                           style: .plain,
                                           target: self,
                                           action: nil)
                self.items = [deleteItem, flexibleSpace, shareItem]
            case .onlyAdd:
                self.items = [flexibleSpace, addItem]
            case let .titleWithAdd(count, total):
                let titleItem = UIBarButtonItem(title: "\(count) items · Counted \(total) times" ,
                                                style: .plain,
                                                target: self,
                                                action: nil)
                titleItem.tintColor = UIColor.Pallete.darkSilver
                self.items = [flexibleSpace, titleItem, flexibleSpace, addItem]
            case .empty:
                self.items = []
            }
        }
    }
    
}
