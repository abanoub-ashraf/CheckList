import UIKit

// protocol that only works on classes
protocol ItemDetailVCDelegate: class {
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailVC)
    func itemDetailViewController(_ controller: ItemDetailVC, didFinishAdding item: CheckListItem)
    func itemDetailViewController(_ controller: ItemDetailVC, didFinsihEditing item: CheckListItem)
}

class ItemDetailVC: UITableViewController {
    
    // delegate for our protocol to be able to call its function from this VC
    weak var delegate: ItemDetailVCDelegate?
    
    // properties to recieve the data that's gonna be passed to this VC
    weak var todoList: TodoList?
    weak var itemToEdit: CheckListItem?
    
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // never use a large title
        navigationItem.largeTitleDisplayMode = .never
        // assign this class to be the delegate of UITextFieldDelegate in the extension
        textField.delegate = self
        
        /** if there's an item to edit then we are editing item rn not adding new one **/
        if let item = itemToEdit {
            // change the nav bar title
            title = "Edit Item"
            // get the text that's in the item to edit it
            textField.text = item.text
            // enable the add bar button
            addBarButton.isEnabled = true
        }
    }
    
    // make the keyboard appear automatically instead of clicking on the text field to do so
    override func viewWillAppear(_ animated: Bool) {
        // make the text field the first object to respond once this VC appear on the screen
        // so the keyboard will be shown automatically
        textField.becomeFirstResponder()
    }

    // button responsible for adding new item or editing an existing one
    @IBAction func done(_ sender: Any) {
        /** press to edit an existing item **/
        // if there was an item to edit from the previous VC, and a text in the text field of this current Vc
        if let item = itemToEdit, let text = textField.text {
            // set the text in the text field to be the new value for the item
            item.text = text
            // call this method to finisi editing
            delegate?.itemDetailViewController(self, didFinsihEditing: item)
        } else {
            /** press to add a new item **/
            // if it's a new item and
            if let item = todoList?.newTodo() {
                // if there was text in the text field
                if let textFieldText = textField.text {
                    // set that text to be the text of that new item
                    item.text = textFieldText
                }
                // set this to false
                item.checked = false
                // call this method to add the item we created to the previous VC
                delegate?.itemDetailViewController(self, didFinishAdding: item)
            }
        }
    }
    
    // dismiss the current VC
    @IBAction func cancel(_ sender: Any) {
        // call this method to dismiss this VC and go back to the previous one
        delegate?.itemDetailViewControllerDidCancel(self)
    }
    
    // determine whether the row can be selected or not
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
}

// extend our AddItemVC Class
extension ItemDetailVC: UITextFieldDelegate {
    
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
