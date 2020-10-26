//
// Copyright © 2020 Dictys. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    var database = Database.shared

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if indexPath.section == 4 && indexPath.row == 1 {
            database.purge()
            database.populate()
        }
    }
}
