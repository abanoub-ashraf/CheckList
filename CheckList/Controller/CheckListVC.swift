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
        // cast the cell to the cell class we created
        if let checkmarkCell = cell as? CheckListCell {
            // now access its todoTextLabel to set its text to be the text of the item
            checkmarkCell.todoTextLabel.text = item.text
        }
    }

    // confiure the checkmarks in each cell
    // pass the checklist item to it to toggle its statue
    func configureCheckMark(for cell: UITableViewCell, with item: CheckListItem) {
        guard let checkmarkCell = cell as? CheckListCell else {
            return
        }
        if item.checked {
            checkmarkCell.checkmarkLabel.text = "√"
        } else {
            checkmarkCell.checkmarkLabel.text = ""
        }
        // then change the statue of the checked attibute in the item model class cause the cell's clicked
        item.toggleChecked()
    }
    
    // a method that's called when you wanna go from VC to another
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // to diffrentiate every single segue from the other, if there was many
        /** this identifier is for adding new item **/
        if segue.identifier == "AddItemSegue" {
            // as? cause destination returns a UI which must be casted
            // itemDetailViewController is gonna be instance of the destination VC
            if let itemDetailViewController = segue.destination as? ItemDetailVC {
                // set this CheckListVC to be the delegate for AddItemVC
                itemDetailViewController.delegate = self
                // assign the data (todoList of this current VC) to the todoList property of that destination
                itemDetailViewController.todoList = todoList
            }
            /** this identifier is for editing an existing item **/
        } else if segue.identifier == "EditItemSegue" {
            // itemDetailViewController is gonna be instance of the destination VC
            if let itemDetailViewController = segue.destination as? ItemDetailVC {
                // pass the cell the user tapped on to the second VC
                // this method returns indexPath, pass the cell to it to get where the user taped
                if let cell = sender as? UITableViewCell,
                   let indexPath = tableView.indexPath(for: cell) {
                    // now get the item of that indexPath
                    let item = todoList.todos[indexPath.row]
                    // pass that item to the destination VC's property
                    itemDetailViewController.itemToEdit = item
                    itemDetailViewController.delegate = self
                }
            }
        }
    }
    
}

// make this class conform to that protocol and implement its methods
// this VC will implment these 2 methods that will be called in the AddItemVC
extension CheckListVC: ItemDetailVCDelegate {
    
    //  dismis the current VC that will call this method which is AddItemVC
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailVC) {
        navigationController?.popViewController(animated: true)
    }
    
    // add the new item to the table view of this VC when this method is called from the other one
    func itemDetailViewController(_ controller: ItemDetailVC, didFinishAdding item: CheckListItem) {
        // the new position for the new item
        // cause we already have the new item inside the array
        let rowIndex = todoList.todos.count - 1
        // the new indexPath for the new item
        let indexPath = IndexPath(row: rowIndex, section: 0)
        // array for the insert table view's method
        let indexPaths = [indexPath]
        // add the item to the table view
        tableView.insertRows(at: indexPaths, with: .automatic)
        // then dismiss the current VC and go back to the prevois one
        navigationController?.popViewController(animated: true)
    }
    
    // update the table row that represent that checklist item
    func itemDetailViewController(_ controller: ItemDetailVC, didFinsihEditing item: CheckListItem) {
        // search for the item
        if let index = todoList.todos.index(of: item) {
            // get the indexPath based on the index we created
            let indexPath = IndexPath(row: index, section: 0)
            // get the cell based on that indexPath
            if let cell = tableView.cellForRow(at: indexPath) {
                // configure the text of that cell
                configureText(for: cell, with: item)
            }
        }
        // finally pop the VC ater we're done
        navigationController?.popViewController(animated: true)
    }
    
    
}
