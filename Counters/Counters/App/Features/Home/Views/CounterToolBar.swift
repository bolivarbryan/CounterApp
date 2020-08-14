//
//  CounterToolBar.swift
//  Counters
//
//  Created by Bryan Bolivar on 10/08/20.
//

import Foundation
import UIKit
import Components

protocol CounterToolBarDelegate {
    func didSelectDelete()
    func didSelectAdd()
    func didSelectShare()
}

class CounterToolBar: UIToolbar {
    enum State {
        case deleteAndShare
        case onlyAdd
        case titleWithAdd(count: Int, total: Int)
    }
    
    lazy var flexibleSpace = UIBarButtonItem(systemItem: .flexibleSpace, primaryAction: nil, menu: nil)
    lazy var addItem = UIBarButtonItem(image: Image.plus.imageRepresentation,
                               style: .plain,
                               target: self,
                               action: #selector(selectAdd))
    
    var toolBarDelegate: CounterToolBarDelegate?
    
    var state: State  = .onlyAdd {
        didSet {
            switch state {
            case .deleteAndShare:
                let deleteItem = UIBarButtonItem(image: Image.trash.imageRepresentation,
                                           style: .plain,
                                           target: self,
                                           action: #selector(selectDelete))
                
                let shareItem = UIBarButtonItem(image: Image.share.imageRepresentation,
                                           style: .plain,
                                           target: self,
                                           action: #selector(selectShare))
                self.items = [deleteItem, flexibleSpace, shareItem]
            case .onlyAdd:
                self.items = [flexibleSpace, addItem]
            case let .titleWithAdd(count, total):
                let value = String(format: Language.Main.totalCount.localizedValue, count, total)
                let titleItem = UIBarButtonItem(title: value ,
                                                style: .plain,
                                                target: self,
                                                action: nil)
                titleItem.tintColor = UIColor.Pallete.darkSilver
                self.items = [flexibleSpace, titleItem, flexibleSpace, addItem]
            }
        }
    }
    
    @objc func selectDelete() {
        toolBarDelegate?.didSelectDelete()
    }
    
    @objc func selectShare() {
        toolBarDelegate?.didSelectShare()
    }
 
    @objc func selectAdd() {
        toolBarDelegate?.didSelectAdd()
    }
}
