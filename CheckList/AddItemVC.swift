import UIKit

class AddItemVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // never use a large title
        navigationItem.largeTitleDisplayMode = .never
    }

    @IBAction func done(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    // dismiss the current VC
    @IBAction func cancel(_ sender: Any) {
        // pop the current VC and go back to the previous one
        navigationController?.popViewController(animated: true)
    }
}

