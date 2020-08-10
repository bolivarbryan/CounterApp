//
//  UILabel+Style.swift
//  Counters
//
//  Created by Bryan Bolivar on 9/08/20.
//

import Foundation
import UIKit

extension UILabel {
    ///Transforms UILabel appearance to Title Style
    public func configureAsTitle() {
        font = UIFont.CounterFont.title
        lineBreakMode = .byWordWrapping
        numberOfLines = 0
        validateDebugMode()
    }
    
    ///Transforms UILabel appearance to Body Style
    public func configureAsBody() {
        font = UIFont.CounterFont.body
        lineBreakMode = .byWordWrapping
        numberOfLines = 0
        textColor = UIColor.Pallete.gray74
        validateDebugMode()
    }
    
    public func configureAsBodyTitle() {
        font = UIFont.CounterFont.bodyTitle
        lineBreakMode = .byWordWrapping
        numberOfLines = 0
        textColor = .black
        validateDebugMode()
    }
    
    func validateDebugMode() {
        if UserDefaults.standard.string(forKey: "debug_mode") == nil {
            backgroundColor = .clear
        } else {
            backgroundColor = #colorLiteral(red: 0.9150560498, green: 0.9150775075, blue: 0.9150659442, alpha: 1)
        }
    }
}