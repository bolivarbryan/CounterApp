//
//  ViewController.swift
//  Counters
//
//  Created by Bryan Bolivar on 9/08/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = Language.Welcome.title.localizedValue
            titleLabel.configureAsTitle()
        }
    }
    
    @IBOutlet weak var bodyLabel: UILabel! {
        didSet {
            bodyLabel.configureAsBody()
            bodyLabel.attributedText = NSMutableAttributedString(string: Language.Welcome.subtitle.localizedValue, attributes: [NSAttributedString.Key.kern: 0.34])
        }
    }
    
    @IBOutlet weak var continueButton: UIButton! {
        didSet {
            continueButton.configureButtonStyle(size: .large)
            continueButton.setTitle(Language.Welcome.continueButton.localizedValue, for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        for i in Language.Welcome.allCases {
//            print("\"\(i.sectionName).\(i.rawValue)\" = \"\";")
//        }
    }


}

