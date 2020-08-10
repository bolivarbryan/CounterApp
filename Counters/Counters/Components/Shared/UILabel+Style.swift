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
    func configureAsTitle() {
        font = UIFont.CounterFont.title
        lineBreakMode = .byWordWrapping
        numberOfLines = 0
        backgroundColor = .clear
    }
    
    ///Transforms UILabel appearance to Body Style
    func configureAsBody() {
        font = UIFont.CounterFont.body
        lineBreakMode = .byWordWrapping
        numberOfLines = 0
        textColor = UIColor.Pallete.gray74
        backgroundColor = .clear
    }
}
