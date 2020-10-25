//
// Copyright © 2020 Dictys. All rights reserved.
//

import UIKit

class WordCell: UITableViewCell {
    @IBOutlet var originalLabel: UILabel!
    @IBOutlet var translatedLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

// https://developer.apple.com/documentation/uikit/uifont/creating_self-sizing_table_view_cells
