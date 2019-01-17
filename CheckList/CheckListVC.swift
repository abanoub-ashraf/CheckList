import UIKit

class CheckListVC: UITableViewController {
    
    // integrate the Model todoList's class in this Controller class
    var todoList: TodoList
    
    // intializer for the TodoList's object
    required init?(coder aDecoder: NSCoder) {
        todoList = TodoList()
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - UITableViewDataSource Methods
    /////////////////////////////////////////
    
    // how many rows to display
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // the number of the items inside the todos array in the TodoList Class Model
        return todoList.todos.count
    }
    
    // the content of each cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a cell then keep re-using it
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckListItem", for: indexPath)
        // this method returns a view based on its tag that's given in storyboard
            // if there's a view that's tag is 1000 set it as value of the label variable
            if let label = cell.viewWithTag(1000) as? UILabel {
                // set the label's text of each cell to the text of each item in the array of the todolist model
                label.text = todoList.todos[indexPath.row].text
            }
        configureCheckMark(for: cell, at: indexPath)
        return cell
    }
    
    //MARK: - UITableViewDelegate Methods
    ///////////////////////////////////////
    
    // interact with the cell when it got selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // this method returns optional cell cause there might or might not be a cell to return in that indexPath
        if let cell = tableView.cellForRow(at: indexPath) {
            // configure the checkmark of every cell
            configureCheckMark(for: cell, at: indexPath)
            // deselect the row that you selected, this remove the highlight that was on the cell when it's selected
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    // confiure the checkmarks in each cell
    func configureCheckMark(for cell: UITableViewCell, at indexPath: IndexPath) {
        let isChecked = todoList.todos[indexPath.row].checked
        if isChecked {
            // if checked was true, remove the check mark from the cell
            cell.accessoryType = .none
        } else {
            // if was not true, put it on the cell
            cell.accessoryType = .checkmark
        }
        todoList.todos[indexPath.row].checked = !isChecked
    }
    
}

