//
//  ViewController.swift
//  Counters
//
//  Created by Bryan Bolivar on 9/08/20.
//

import UIKit
import Components

struct WelcomeGuideInfo {
    let image: Image
    let color: UIColor
    let title: Language.Welcome
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
