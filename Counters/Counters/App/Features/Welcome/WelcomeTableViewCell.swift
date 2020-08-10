//
//  WelcomeTableViewCell.swift
//  Counters
//
//  Created by Bryan Bolivar on 9/08/20.
//

import UIKit
import Components

class WelcomeTableViewCell: UITableViewCell {

    static let reuseIdentifier = "WelcomeTableViewCell"
    var info: WelcomeGuideInfo? {
        didSet {
            guard let info = info
            else { return }

            titleLabel.text = info.title.localizedValue
            bodyLabel.text = info.body.localizedValue
            iconImageView.configure(image: info.image, color: info.color)
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.configureAsBodyTitle()
        }
    }
    
    @IBOutlet weak var bodyLabel: UILabel! {
        didSet {
            bodyLabel.configureAsBody()
        }
    }
    
    @IBOutlet weak var iconImageView: RoundedSquareView! {
        didSet {
            iconImageView.configure(image: .lightBulb, color: UIColor.Pallete.green )
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
