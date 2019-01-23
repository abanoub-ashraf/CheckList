import UIKit

class AddItemVC: UITableViewController {
    
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // never use a large title
        navigationItem.largeTitleDisplayMode = .never
        // assign this class to be the delegate of UITextFieldDelegate in the extension
        textField.delegate = self
    }
    
    // make the keyboard appear automatically instead of clicking on the text field to do so
    override func viewWillAppear(_ animated: Bool) {
        // make the text field the first object to respond once this VC appear on the screen
        // so the keyboard will be shown automatically
        textField.becomeFirstResponder()
    }

    @IBAction func done(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    // dismiss the current VC
    @IBAction func cancel(_ sender: Any) {
        // pop the current VC and go back to the previous one
        navigationController?.popViewController(animated: true)
    }
    
    // determine whether the row can be selected or not
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
}

// extend our AddItemVC Class
extension AddItemVC: UITextFieldDelegate {
    
    // make the keyboard goes away once user click on done key
    // Asks the delegate if the text field should process the pressing of the return button.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    // when the user taps a key on the keyboard this method will get called
    // this method manipulates what the user is typing before it's reflected in the actual text feild
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // guard those two if they are empty (return nil), else return false
        guard let oldText = textField.text,
              let stringRange = Range(range, in: oldText) else {
                return false
        }
        // replace the old text if there was any, with a new one and store it in this variable
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        if newText.isEmpty {
            // disable the add button if there was no text entered
            addBarButton.isEnabled = false
        } else {
            // enable it if the user typed a text
            addBarButton.isEnabled = true
        }
        return true
    }
    
}
