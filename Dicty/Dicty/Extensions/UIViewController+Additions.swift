//
// Copyright © 2020 Dictys. All rights reserved.
//

import UIKit

public extension UIViewController {
    func add(asChildViewController viewController: UIViewController, to parentView: UIView) {
        addChild(viewController)
        parentView.addSubview(viewController.view)
        viewController.view.frame = parentView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }

    func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
}

public extension UIViewController {
    func setupToHideKeyboardOnTapOnView() {
        let tap = UITapGestureRecognizer( target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
