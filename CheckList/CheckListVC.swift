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
        // hold each item in each row in this variable item
        let item = todoList.todos[indexPath.row]
        // pass the item to this method to configure the text in each cell
        configureText(for: cell, with: item)
        // pass the cell to this method to configure the checkmark in eah cell
        configureCheckMark(for: cell, with: item)
        return cell
    }
    
    //MARK: - UITableViewDelegate Methods
    ///////////////////////////////////////
    
    // interact with the cell when it got selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // this method returns optional cell cause there might or might not be a cell to return in that indexPath
        if let cell = tableView.cellForRow(at: indexPath) {
            // hold each item in a variable item
            let item = todoList.todos[indexPath.row]
            // configure the checkmark of every cell once it's clicked
            configureCheckMark(for: cell, with: item)
            // deselect the row that you selected, this remove the highlight that was on the cell when it's selected
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    // configure the text of the label in each cell
    // pass the checklist item to it to get its text
    func configureText(for cell: UITableViewCell, with item: CheckListItem) {
        // this method returns a view based on its tag that's given in storyboard
        // if there's a view that's tag is 1000 set it as value of the label variable
        if let label = cell.viewWithTag(1000) as? UILabel {
            // set the label's text of each cell to the text of each item in the array of the todolist model
            label.text = item.text
        }
    }
    
    // confiure the checkmarks in each cell
    // pass the checklist item to it to toggle its statue
    func configureCheckMark(for cell: UITableViewCell, with item: CheckListItem) {
        if item.checked {
            // if checked was true, remove the check mark from the cell
            cell.accessoryType = .none
        } else {
            // if it was not true, put it on the cell
            cell.accessoryType = .checkmark
        }
        // then change the statue of the checked attibute in the item model class cause the cell's clicked
        item.toggleChecked()
    }
    
}
