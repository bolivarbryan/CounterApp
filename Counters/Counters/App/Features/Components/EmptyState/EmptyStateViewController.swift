//
//  EmptyStateViewController.swift
//  Counters
//
//  Created by Bryan Bolivar on 10/08/20.
//

import UIKit
import Components

protocol EmptyStateDelegate {
    func didSelectActionButton()
    
    var titleLabel: String { get }
    var descriptionLabel: String { get }
    var actionButtonTitle: String { get }
}

class EmptyStateViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    
    var delegate: EmptyStateDelegate? {
        didSet {
            actionButton.setTitle(delegate?.actionButtonTitle, for: .normal)
            actionButton.configureButtonStyle(size: .small)
            
            titleLabel.text = delegate?.titleLabel
            titleLabel.configureAsBodyTitle()
            
            descriptionLabel.text = delegate?.descriptionLabel
            descriptionLabel.configureAsBody()
            descriptionLabel.textAlignment = .center
            descriptionLabel.textColor = UIColor.Pallete.darkSilver
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Pallete.gray230
    }

}
