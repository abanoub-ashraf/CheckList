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
        // set random title to the text of each new item
        item.text = randomTitle()
        // make every new item is checked by default
        item.checked = true
        todos.append(item)
        return item
    }
    
    // generate random titles for the each new item
    private func randomTitle() -> String {
        // array of some titles
        var titles = [
            "New todo item",
            "Generic todo",
            "Fill me out",
            "I need something to do",
            "Much todo about nothing"
        ]
        // generate random number in range from 0 to the size of the titles array
        let randomNumber = Int.random(in: 0...titles.count - 1)
        // then return any title of the array based on the random generated nubmer
        return titles[randomNumber]
    }
    
}
