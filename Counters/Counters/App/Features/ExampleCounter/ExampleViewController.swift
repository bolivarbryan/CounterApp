import UIKit
import Components

class ExampleViewController: UIViewController {

    @IBOutlet weak var selectAnExampleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var viewModel = ExampleViewModel()
    var delegate: ExampleViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Language.Examples.title.localizedValue
        selectAnExampleLabel.configureAsViewSubtitle()
        selectAnExampleLabel.text = Language.Examples.subtitle.localizedValue
        navigationItem.largeTitleDisplayMode = .never
        tableView.contentInset.top = 20
    }
    
    @objc func goBackToPreviousScreen() {
        self.navigationController?.popViewController(animated: true)
    }

}

extension ExampleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExampleCellD") as! ExampleTableViewCell
        cell.model = viewModel.datasource[indexPath.row]
        cell.delegate = self
        return cell
    }
}

extension ExampleViewController: ExampleViewDelegate {
    func didSelectTitle(title: String) {
        delegate?.didSelectTitle(title: title)
        goBackToPreviousScreen()
    }
}
