//
// Copyright © 2020 Dictys. All rights reserved.
//

import UIKit

class MonthWordViewController: UIViewController {
    let monthWordView = MonthWordView()

    override func loadView() {
      self.view = monthWordView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
