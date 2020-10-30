//
//  MainPageView.swift
//  Dicty
//
//  Created by a.chetverov on 27.10.2020.
//  Copyright © 2020 Dictys. All rights reserved.
//

import TinyConstraints
import UIKit

class MainPageView: UIView {
    var monthWordView: UIView?
    var translateWordView: UIView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setSubviewForAutoLayout(self.verticalStackView)
        verticalStackView.edgesToSuperview(insets: .top(10) + .left(20) + .right(20) + .bottom(UIScreen.main.bounds.height * 0.1), usingSafeArea: true)
        self.backgroundColor = .white
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 10.0
        return stackView
    }()

    func setupViews(monthWordView: UIView, translateWordView: UIView) {
        self.monthWordView = monthWordView
        self.translateWordView = translateWordView

        monthWordView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.addArrangedSubview(monthWordView)
        monthWordView.edgesToSuperview(excluding: .bottom)
        monthWordView.heightToSuperview(multiplier: 0.2)

        translateWordView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.addArrangedSubview(translateWordView)
        translateWordView.edgesToSuperview(excluding: .top)
    }
}
