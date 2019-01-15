//import UIKit
//
//class TestVC: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//
//}
//
//// DataSource: Send data to the table
///** extend the class TestVC to make it inherit from UITableViewDataSource **/
//extension TestVC: UITableViewDataSource {
//
//    // how many rows to display
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1000
//    }
//
//    // the content of each cell
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        // create a cell then keep re-using it
//        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckListItem", for: indexPath)
//        // this method returns a view based on its tag that's given in storyboard
//        // if there's a view that's tag is 1000 set it as value of the label variable
//        if let label = cell.viewWithTag(1000) as? UILabel {
//            // if it was in the row number 0
//            if indexPath.row % 5 == 0 {
//                label.text = "Take a jog"
//            } else if indexPath.row % 4 == 0 {
//                label.text = "Wtach a movie"
//            } else if indexPath.row % 3 == 0 {
//                label.text = "Code an app"
//            } else if indexPath.row % 2 == 0 {
//                label.text = "Walk the dog"
//            } else if indexPath.row % 1 == 0 {
//                label.text = "Study design patterns"
//            }
//        }
//        return cell
//    }
//
//}
//
//// Delegate: interacts with the table
///** extend the class TestVC to make it inherit from UITableViewDelegate **/
//extension TestVC: UITableViewDelegate {}
