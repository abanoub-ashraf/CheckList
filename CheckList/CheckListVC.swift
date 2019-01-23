import UIKit

class CheckListVC: UITableViewController {
    
    // integrate the Model todoList's class in this Controller class
    var todoList: TodoList
    
    // add new checklist item to the table view
    @IBAction func addItem(_ sender: Any) {
        // create new row for the new indexPath we'll create, then add it to the end of the table
        // the table gets its size from the size of the todos array so that's the end of the table
        let newRowIndex = todoList.todos.count
        // _ means idc about the object returns from this method just call it and that's it
        _ = todoList.newTodo()
        // create new indexPath for the new item, to add it to the table view
        // passing the new row we created to it as the postion
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        // inserting function requires an array of indexPaths
        let indexPaths = [indexPath]
        // now insert the new index path we created
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    // initializer for the TodoList's object
    required init?(coder aDecoder: NSCoder) {
        todoList = TodoList()
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // access the navigation bar in cide
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    //MARK: - UITableViewDataSource Methods:
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
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   
    //MARK: - UITableViewDelegate Methods:
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
    
    // delete the cell when it gets swiped
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // delete from the model itself using the indexPath
        todoList.todos.remove(at: indexPath.row)
        // now delete from the table view on screen using same indexPath ofc
        let indexPaths = [indexPath]
        // the delete method requires array of indexPaths too
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
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
            cell.accessoryType = .checkmark
        } else {
            // if it was not true, put it on the cell
            cell.accessoryType = .none
        }
        // then change the statue of the checked attibute in the item model class cause the cell's clicked
        item.toggleChecked()
    }
    
}
