import UIKit
import Components

class AddCounterViewController: UIViewController {
    enum State {
        case normal
        case content
        case saving
        case error
    }
    
    @IBOutlet weak var counterNameTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var seeExamplesButton: UIButton!
    
    var viewModel = AddCounterViewModel()
    var cancelButton: UIBarButtonItem {
        UIBarButtonItem(title: Language.CreateACounter.cancel.localizedValue,
                                                           style: .plain,
                                                           target: self, action: #selector(goBackToPreviousScreen))
    }
    
    var saveButton: UIBarButtonItem {
        UIBarButtonItem(title: Language.CreateACounter.save.localizedValue,
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(saveCounter))
    }
    
    var state: State = .normal {
        didSet {
            configureScreenForState()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        state = .normal
    }
    
    func configureUI() {
        title = Language.CreateACounter.title.localizedValue
        view.backgroundColor = UIColor.Pallete.backgroundColor
        seeExamplesButton.titleLabel?.configureAsBody()
        seeExamplesButton.setTitle(Language.CreateACounter.suggestionText.localizedValue, for: .normal)
        seeExamplesButton.tintColor = UIColor.Pallete.darkSilver
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = saveButton
    }
    
    func configureScreenForState()  {
        switch state {
        case .content:
            navigationItem.leftBarButtonItem?.isEnabled = true
            navigationItem.rightBarButtonItem?.isEnabled = true
            activityIndicator.stopAnimating()
        case .normal:
            navigationItem.leftBarButtonItem?.isEnabled = true
            navigationItem.rightBarButtonItem?.isEnabled = false
            activityIndicator.stopAnimating()
        case .saving:
            navigationItem.leftBarButtonItem?.isEnabled = true
            navigationItem.rightBarButtonItem?.isEnabled = false
            activityIndicator.startAnimating()
        case .error:
            navigationItem.rightBarButtonItem?.isEnabled = false
            navigationItem.leftBarButtonItem?.isEnabled = false
            presentAlertForError()
        }
    }
    
    @IBAction func loadExamplesView(_ sender: Any) {
    }
    
    @objc func saveCounter() {
        guard let text = counterNameTextField.text else {
            return
        }
        self.state = .saving
        viewModel.saveCounter(title: text) { success in
            if success {
                self.goBackToPreviousScreen()
            } else {
                self.state = .error
            }
        }
    }

    
    @IBAction func textfieldUpdated(_ sender: UITextField) {
        guard let text = sender.text else {
            state = .normal
            return
        }
        
        if text.isEmpty {
            state = .normal
        } else {
            state = .content
        }
    }
    
    @objc func goBackToPreviousScreen() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func presentAlertForError() {
        let actionSheet = UIAlertController(title: Language.CreateACounter.errorCreatingCounter.localizedValue,
                                            message: Language.CreateACounter.errorInternetConnection.localizedValue,
                                            preferredStyle: .alert)
        
        actionSheet.addAction(UIAlertAction(title:Language.CreateACounter.dismiss.localizedValue,
                                            style: .cancel) { _ in
            self.state = .content
        })
        
        actionSheet.view.tintColor = UIColor.Pallete.tintColor
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
