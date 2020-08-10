import UIKit
import Components

/// Guide Information which contains relevant information for new users
struct WelcomeGuideInfo {
    /// Image icon for guide info
    let image: Image
    /// Background color
    let color: UIColor
    /// Title text for guide info
    let title: Language.Welcome
    /// Description text for guide info
    let body: Language.Welcome
}

class ViewController: UIViewController {
    let datasource: [WelcomeGuideInfo] = [
        WelcomeGuideInfo(image: .number(value: 42), color: UIColor.Pallete.red , title: .addAlmostAnything , body: .addAlmostAnythingValue),
        WelcomeGuideInfo(image: .people, color: UIColor.Pallete.yellow , title: .countToSelf , body: .countToSelfValue),
        WelcomeGuideInfo(image: .lightBulb, color: UIColor.Pallete.green , title: .countYourToughts , body: .countYourToughtsValue),
    ]
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = Language.Welcome.title.localizedValue
            titleLabel.configureAsTitle()
            
            let string_to_color = "Counters"
            let main_string = Language.Welcome.title.localizedValue
            let range = (main_string as NSString).range(of: string_to_color)

            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 7
            let attribute = NSMutableAttributedString.init(string: main_string)
            attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.Pallete.tintColor , range: range)
            attribute.addAttribute(.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, main_string.count - 1 ))

            titleLabel.attributedText = attribute
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

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WelcomeTableViewCell.reuseIdentifier) as! WelcomeTableViewCell
        cell.info = datasource[indexPath.row]
        return cell
    }
}
