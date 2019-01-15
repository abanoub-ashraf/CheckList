import UIKit

class CheckListVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - UITableViewDataSource Methods
    
    // how many rows to display
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1000
    }
    
    // the content of each cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a cell then keep re-using it
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckListItem", for: indexPath)
        // this method returns a view based on its tag that's given in storyboard
            // if there's a view that's tag is 1000 set it as value of the label variable
            if let label = cell.viewWithTag(1000) as? UILabel {
                // if it was in the row number 0
                if indexPath.row % 5 == 0 {
                    label.text = "Take a jog"
                } else if indexPath.row % 4 == 0 {
                    label.text = "Wtach a movie"
                } else if indexPath.row % 3 == 0 {
                    label.text = "Code an app"
                } else if indexPath.row % 2 == 0 {
                    label.text = "Walk the dog"
                } else if indexPath.row % 1 == 0 {
                    label.text = "Study design patterns"
                }
            }
        return cell
    }
    
    //MARK: - UITableViewDelegate Methods
    
    // interact with the cell when it got selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // this method returns optional cell cause there might or might not be a cell to return in that indexPath
        if let cell = tableView.cellForRow(at: indexPath) {
            // if the cell has no checkmark, put one on it, else remove the checkmark
            if cell.accessoryType == .none {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        }
        // deselect the row that you selected, this remove the highlight that was on the cell when it's selected
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
