import UIKit

class CheckListCell: UITableViewCell {
    
    @IBOutlet weak var todoTextLabel: UILabel!
    @IBOutlet weak var checkmarkLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
