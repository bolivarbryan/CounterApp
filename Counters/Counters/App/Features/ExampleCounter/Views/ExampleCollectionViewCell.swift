import UIKit
import Components

class ExampleCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.configureAsBody()
        titleLabel.textColor = .black
    }
}
