import UIKit
import Components

protocol CounterTableViewCellDelegate {
    func counterValueDidUpdate(counter: Counter)
}

class CounterTableViewCell: UITableViewCell {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    var delegate: CounterTableViewCellDelegate?
    
    var counter: Counter? {
        didSet {
            guard let counter = counter else {
                return
            }
            
            countLabel.text = String(counter.value)
            nameLabel.text = counter.title
            countLabel.configureAsCellLargeTitle(enabled: counter.value > 0)
            stepper.value = Double(counter.value)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        countLabel.configureAsCellLargeTitle(enabled: true)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    @IBAction func updateCounterValue(_ sender: UIStepper) {
        guard let counter = counter else {
            return
        }
        counter.value = Int(sender.value)
        delegate?.counterValueDidUpdate(counter: counter)
        self.counter = counter
    }
    
}
