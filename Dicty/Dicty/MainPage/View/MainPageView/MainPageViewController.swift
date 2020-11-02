//
// Copyright © 2020 Dictys. All rights reserved.
//

import TinyConstraints
import UIKit
import RxSwift

class MainPageViewController: UIViewController {
    let mainView = MainPageView()

    private let disposeBag = DisposeBag()
    let viewModel = MainPageViewModel()

    override func loadView() {
        self.view = mainView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "Новое слово"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeToKeyboardNotifications()
        setupChildControllers()
    }

    func setupChildControllers() {
        let monthWordViewController = MonthWordViewController()
        let translateViewController = TranslateViewController()

        self.addChild(monthWordViewController)
        self.addChild(translateViewController)

        monthWordViewController.didMove(toParent: self)
        translateViewController.didMove(toParent: self)

        translateViewController.viewModel = self.viewModel

        mainView.setupViews(monthWordView: monthWordViewController.view, translateWordView: translateViewController.view)
    }
}

// анимация под клавиатуру
extension MainPageViewController {

    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    // dynamic ?
    @objc dynamic func keyboardWillShow(_ notification: NSNotification) {
        //print("keyboardWillShow")
        animateWithKeyboard(notification: notification) { keyboardFrame in
            //let constant = 20 + keyboardFrame.height
            //self.mainView.monthWordView?.isOpaque = true
            //self.mainView.monthWordView?.constraints.activate()
            guard let wordView = self.mainView.monthWordView else {
                return
            }

            if !wordView.isHidden {
                print("hide view")
                wordView.isHidden = true
            }
        }
    }

    @objc dynamic func keyboardWillHide(_ notification: NSNotification) {
        animateWithKeyboard(notification: notification) { keyboardFrame in
            //self.textFieldTrailingConstraint?.constant = 20
            guard let wordView = self.mainView.monthWordView else {
                return
            }

            if wordView.isHidden {
                print("show view")
                wordView.isHidden = false
            }
        }
    }

    func animateWithKeyboard(notification: NSNotification,
                             animations: ((_ keyboardFrame: CGRect) -> Void)?) {
        let durationKey = UIResponder.keyboardAnimationDurationUserInfoKey
        guard let duration = notification.userInfo![durationKey] as? Double else {
            return
        }

        let frameKey = UIResponder.keyboardFrameEndUserInfoKey
        guard let keyboardFrameValue = notification.userInfo![frameKey] as? NSValue else {
            return
        }

        let curveKey = UIResponder.keyboardAnimationCurveUserInfoKey
        guard let curveValue = notification.userInfo![curveKey] as? Int else {
            return
        }
        let curve = UIView.AnimationCurve(rawValue: curveValue)!

        let animator = UIViewPropertyAnimator(duration: duration, curve: curve) {
            animations?(keyboardFrameValue.cgRectValue)
            print("layout")
            self.mainView.layoutIfNeeded()
        }
        print("start")
        animator.startAnimation()
    }
}
