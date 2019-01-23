import UIKit

class AddItemVC: UITableViewController {
    
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
        print("Contents of the text field \(textField)")
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
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
}
