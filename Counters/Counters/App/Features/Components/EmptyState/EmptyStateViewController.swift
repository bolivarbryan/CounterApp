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
}

class EmptyStateViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.configureAsBodyTitle()
        }
    }
    
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.configureAsBody()
            descriptionLabel.textAlignment = .center
            descriptionLabel.textColor = UIColor.Pallete.darkSilver
        }
    }
    
    @IBOutlet weak var actionButton: UIButton! {
        didSet {
            actionButton.configureButtonStyle(size: .small)
        }
    }
    
    var delegate: EmptyStateDelegate?
    
    func reloadInfo(title: Localizable?, body: Localizable?, action: Localizable?) {
        actionButton.setTitle(action?.localizedValue, for: .normal)
        titleLabel.text = title?.localizedValue
        descriptionLabel.text = body?.localizedValue
        actionButton.isHidden = (action == nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Pallete.gray230
    }

    @IBAction func sendAction(_ sender: Any) {
        delegate?.didSelectActionButton()
    }
}
