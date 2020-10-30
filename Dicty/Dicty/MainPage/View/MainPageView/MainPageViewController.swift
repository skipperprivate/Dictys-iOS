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
        setupChildControllers()
    }

    func setupChildControllers() {
        let monthWordViewController = MonthWordViewController()
        let translateViewController = TranslateViewController()

        self.addChild(monthWordViewController)
        self.addChild(translateViewController)

        monthWordViewController.didMove(toParent: self)
        translateViewController.didMove(toParent: self)

        mainView.setupViews(monthWordView: monthWordViewController.view, translateWordView: translateViewController.view)

        viewModel
            .translate
            .observeOn(MainScheduler.instance)
            .bind(to: translateViewController.translate)
            .disposed(by: disposeBag)
    }
}
