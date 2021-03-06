import UIKit
import Components

protocol CounterTableViewCellDelegate {
    func counterValueDidUpdate(counter: Counter, newValue: Int)
    func toggleCounterSelection(counter: Counter)
}

class CounterTableViewCell: UITableViewCell {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var selectionButton: UIButton!
    @IBOutlet weak var selectionButtonWidthConstraint: NSLayoutConstraint!
    
    var delegate: CounterTableViewCellDelegate?
    
    var counter: Counter? {
        didSet {
            guard let counter = counter else {
                return
            }
            
            countLabel.text = String(counter.count)
            nameLabel.text = counter.title
            countLabel.configureAsCellLargeTitle(enabled: counter.count > 0)
            stepper.value = Double(counter.count)
        }
    }
    
    var state: HomeViewController.State = .normal {
        didSet {
            switch state {
            case .editingEnabled:
                selectionButtonWidthConstraint.constant = 39
                stepper.isEnabled = false
            default:
                selectionButtonWidthConstraint.constant = 0
                stepper.isEnabled = true
            }
        }
    }
    
    var isCounterSelected: Bool = false {
        didSet {
            selectionButton.isSelected = isCounterSelected
            selectionButton.tintColor = isCounterSelected ? UIColor.Pallete.tintColor : UIColor.Pallete.gray43
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        countLabel.configureAsCellLargeTitle(enabled: true)
        selectionButton.setImage(Components.Image.circle.imageRepresentation, for: .normal)
        selectionButton.setImage(Components.Image.circleCheckMark.imageRepresentation, for: .selected)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    @IBAction func updateCounterValue(_ sender: UIStepper) {
        sender.isEnabled = false
        guard let counter = counter else { return }
//        counter.count = Int(sender.value)
        delegate?.counterValueDidUpdate(counter: counter, newValue: Int(sender.value) - counter.count)
//        self.counter = counter
    }
    
    @IBAction func toggleCounterSelection(_ sender: UIStepper) {
        guard let counter = counter else { return }
        delegate?.toggleCounterSelection(counter: counter)
    }
    
}
