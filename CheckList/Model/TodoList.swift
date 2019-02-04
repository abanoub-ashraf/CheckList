import Foundation

// the Model of the TodoList (set of CheckList Items)
class TodoList {
    
    // means we can loop throught the cases of this enum
    enum Priority: Int, CaseIterable {
        case high, medium, low, no
    }
    
    // array for the items based on the their priorities
    private var highPriorityTodos: [CheckListItem] = []
    private var mediumPriorityTodos: [CheckListItem] = []
    private var lowPriorityTodos: [CheckListItem] = []
    private var noPriorityTodos: [CheckListItem] = []
    
    init() {
        
        let row0Item = CheckListItem()
        let row1Item = CheckListItem()
        let row2Item = CheckListItem()
        let row3Item = CheckListItem()
        let row4Item = CheckListItem()
        let row5Item = CheckListItem()
        let row6Item = CheckListItem()
        let row7Item = CheckListItem()
        let row8Item = CheckListItem()
        let row9Item = CheckListItem()
        
        row0Item.text = "Take a Jog"
        row1Item.text = "Watch a movie"
        row2Item.text = "Code an app"
        row3Item.text = "Walk the dog"
        row4Item.text = "Study design patterns"
        row5Item.text = "Go camping"
        row6Item.text = "Pay bills"
        row7Item.text = "Plan vacation"
        row8Item.text = "Walk the cat"
        row9Item.text = "Play games"
        
        addTodo(row0Item, for: .medium)
        addTodo(row1Item, for: .low)
        addTodo(row2Item, for: .high)
        addTodo(row3Item, for: .no)
        addTodo(row4Item, for: .high)
        addTodo(row5Item, for: .medium)
        addTodo(row6Item, for: .low)
        addTodo(row7Item, for: .high)
        addTodo(row8Item, for: .no)
        addTodo(row9Item, for: .high)
    }
    
    // a convienient way to add new todo item
    func addTodo(_ item: CheckListItem, for priority: Priority, at index: Int = -1) {
        switch priority {
            case .high:
                if index < 0 {
                    highPriorityTodos.append(item)
                } else {
                    highPriorityTodos.insert(item, at: index)
                }
            case .medium:
                if index < 0 {
                    mediumPriorityTodos.append(item)
                } else {
                    mediumPriorityTodos.insert(item, at: index)
                }
            case .low:
                if index < 0 {
                    lowPriorityTodos.append(item)
                } else {
                    lowPriorityTodos.insert(item, at: index)
                }
            case .no:
                if index < 0 {
                    noPriorityTodos.append(item)
                } else {
                    noPriorityTodos.insert(item, at: index)
                }
        }
    }
    
    // retrieve specific list of items
    func todoList(for priority: Priority) -> [CheckListItem] {
        switch priority {
            case .high:
                return highPriorityTodos
            case .medium:
                return mediumPriorityTodos
            case .low:
                return lowPriorityTodos
            case .no:
                return noPriorityTodos
        }
    }
    
    // manage adding new items
    func newTodo() -> CheckListItem {
        let item = CheckListItem()
        // set random title to the text of each new item
        item.text = randomTitle()
        // make every new item is checked by default
        item.checked = true
        // all the item are medium priority by default
        mediumPriorityTodos.append(item)
        return item
    }
    
    func move(item: CheckListItem, from sourcePriority: Priority, at sourceIndex: Int, to destinationPriority: Priority, at destinationIndex: Int) {
        remove(item, from: sourcePriority, at: sourceIndex)
        addTodo(item, for: destinationPriority, at: destinationIndex)
    }
    
    // remove the item based on its priority
    func remove(_ item: CheckListItem, from priority: Priority, at index: Int) {
        switch priority {
            case .high:
                highPriorityTodos.remove(at: index)
            case .medium:
                mediumPriorityTodos.remove(at: index)
            case .low:
                lowPriorityTodos.remove(at: index)
            case .no:
                noPriorityTodos.remove(at: index)
        }
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
