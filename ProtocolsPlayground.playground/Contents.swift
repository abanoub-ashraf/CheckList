import UIKit

/** contains set of methods that any class inherits from this protocol muct implement them **/

protocol Persist {
    // methods inside the protocol have no body
    func save()
}

// class comform the methods of that protocol
class Monster: Persist {
    func save() {
        print("Monster save")
    }
}

// class comform the methods of that protocol
class Sword: Persist {
    func save() {
        print("Sword save")
    }
}

class Player {
    
}

let monster = Monster()
let sword = Sword()
let player = Player()

// array of that protocol means any object of any class that inherits from that protocol must implement its methods
let items: [Persist] = [monster, sword]

class GameManager {
    // takes objects of classes that implements that protocol's methods as an argument
    func saveLevel(_ items: [Persist]) {
        for item in items {
            // loop inside them calling the function save()
            item.save()
        }
    }
}

let gameManager = GameManager()
gameManager.saveLevel(items)
