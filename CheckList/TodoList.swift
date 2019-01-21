import Foundation

// the Model of the TodoList (set of CheckList Items)
class TodoList {
    
    // array of type CheckListItem
    var todos: [CheckListItem] = []
    
    init() {
        
        let row0Item = CheckListItem()
        let row1Item = CheckListItem()
        let row2Item = CheckListItem()
        let row3Item = CheckListItem()
        let row4Item = CheckListItem()
        
        row0Item.text = "Take a Jog"
        row1Item.text = "Watch a movie"
        row2Item.text = "Code an app"
        row3Item.text = "Walk the dog"
        row4Item.text = "Study design patterns"
        
        todos.append(row0Item)
        todos.append(row1Item)
        todos.append(row2Item)
        todos.append(row3Item)
        todos.append(row4Item)
    }
    
    // manage adding new items
    func newTodo() -> CheckListItem {
        let item = CheckListItem()
        item.text = "New todo item"
        todos.append(item)
        return item
    }
    
}
