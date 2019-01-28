import Foundation

// the Model for each single Item in the CheckList
class CheckListItem: NSObject {
    
    // attributes of each item inside the lsit
    var text = ""
    var checked = false
    
    // the model should handle its own statue
    func toggleChecked() {
        checked = !checked
    }
    
}
