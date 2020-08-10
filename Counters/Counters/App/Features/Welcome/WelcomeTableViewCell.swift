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
            
            let main_string = info.body.localizedValue
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 2
            let attribute = NSMutableAttributedString.init(string: main_string)
            attribute.addAttribute(.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, main_string.count - 1 ))
            bodyLabel.attributedText = attribute
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
            bodyLabel.textColor = UIColor.Pallete.gray43
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
