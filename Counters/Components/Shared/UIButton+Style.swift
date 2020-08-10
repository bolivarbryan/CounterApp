//
//  UIButton+Style.swift
//  Counters
//
//  Created by Bryan Bolivar on 9/08/20.
//

import Foundation
import UIKit

extension UIButton {
    ///Defines button size behavior
    public enum Size {
        ///Large buttons contains a longer drop shadow
        case large
        
        ///Small buttons contains a shorter drop shadow
        case small
    }
    
    public func configureButtonStyle(size: Size) {
        backgroundColor = UIColor.Pallete.tintColor
        layer.cornerRadius = 8
        titleLabel?.font = UIFont.CounterFont.bodyTitle
        tintColor = .white
        
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        
        layer.shadowOpacity = 1.0
        layer.masksToBounds = false
        
        switch size {
        case .large:
            layer.shadowOffset = CGSize(width: 0, height: 8)
            layer.shadowRadius = 16
        case .small:
            layer.shadowOffset = CGSize(width: 0, height: 4)
            layer.shadowRadius = 8
        }
    }
}
