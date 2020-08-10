import UIKit
import Components

class WelcomeViewController: UIViewController {
    let datasource: [WelcomeGuideInfo] = [
        WelcomeGuideInfo(image: .number(value: 42), color: UIColor.Pallete.red , title: .addAlmostAnything , body: .addAlmostAnythingValue),
        WelcomeGuideInfo(image: .people, color: UIColor.Pallete.yellow , title: .countToSelf , body: .countToSelfValue),
        WelcomeGuideInfo(image: .lightBulb, color: UIColor.Pallete.green , title: .countYourToughts , body: .countYourToughtsValue),
    ]
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.configureAsTitle()
            
            let stringToColor = "Counters"
            let mainString = Language.Welcome.title.localizedValue
            let range = (mainString as NSString).range(of: stringToColor)

            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 7
            
            let attribute = NSMutableAttributedString.init(string: mainString)
            attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.Pallete.tintColor , range: range)
            attribute.addAttribute(.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, mainString.count - 1 ))

            titleLabel.attributedText = attribute
        }
    }
    
    @IBOutlet weak var bodyLabel: UILabel! {
        didSet {
            bodyLabel.configureAsBody()
            bodyLabel.attributedText = NSMutableAttributedString(string: Language.Welcome.subtitle.localizedValue,
                                                                 attributes: [NSAttributedString.Key.kern: 0.34])
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

extension WelcomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WelcomeTableViewCell.reuseIdentifier) as! WelcomeTableViewCell
        cell.info = datasource[indexPath.row]
        return cell
    }
}
