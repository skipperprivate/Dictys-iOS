//
// Copyright © 2020 Dictys. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController {
    // MARK: - SubViews
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var monthWordView: UIView!
    @IBOutlet var translateView: UIView!
    @IBOutlet var titleLabel: UILabel!

    private lazy var monthWordViewController: MonthWordViewController? = {
        guard let storyboard = self.storyboard else {
            return nil
        }

        guard var viewController = storyboard.instantiateViewController(withIdentifier: "MonthWordViewController") as? MonthWordViewController else {
            return nil
        }

        self.add(asChildViewController: viewController, to: monthWordView)
        return viewController
    }()

    private lazy var translateViewController: TranslateViewController? = {
        guard let storyboard = self.storyboard else {
            return nil
        }

        guard var viewController = storyboard.instantiateViewController(withIdentifier: "TranslateViewController") as? TranslateViewController else {
            return nil
        }

        self.add(asChildViewController: viewController, to: translateView)
        return viewController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        stackView.setCustomSpacing(20.0, after: monthWordView)
    }
}
