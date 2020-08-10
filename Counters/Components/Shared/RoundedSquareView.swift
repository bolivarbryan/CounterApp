//
//  RoundedSquareView.swift
//  Components
//
//  Created by Bryan Bolivar on 9/08/20.
//

import UIKit

public class RoundedSquareView: UIImageView {
    
    @IBOutlet weak var imageView: UIImageView? {
        didSet {
            imageView?.tintColor = .white
            imageView?.contentMode = .scaleAspectFit
        }
    }

    ///Prepares View for displaying shape with image and color
    ///- Parameter image: Image from asset for being displayed at UI
    ///- Parameter color: Color from asset for being displayed at UI, only permitted App Colors
    public func configure(image: Image, color: UIColor) {
        layer.backgroundColor = color.cgColor
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.init(white: 0, alpha: 0.05).cgColor
        imageView?.image = image.imageRepresentation
    }
}
