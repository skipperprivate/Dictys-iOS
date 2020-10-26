//
// Copyright © 2020 Dictys. All rights reserved.
//

import TinyConstraints
import UIKit

class MonthWordView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setSubviewForAutoLayout(self.verticalStackView)

//        NSLayoutConstraint.activate([
//            verticalStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
//            verticalStackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
//            verticalStackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0)
//        ])

        verticalStackView.edgesToSuperview(insets: .top(12))



    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Subviews
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 18.0)
        label.textColor = .black
        label.text = "Самое популярное слово за октябрь:"
        return label
    }()

    private let sourceWordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Regular", size: 17.0)
        label.textColor = .black
        label.text = "Tidal"
        return label
    }()

    private let separator: UIView = {
        let separator = UIView()
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separator.backgroundColor = .black
        return separator
    }()

    private let targetWordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Regular", size: 17.0)
        label.textColor = #colorLiteral(red: 0.4240581393, green: 0.4240687788, blue: 0.4240630269, alpha: 1)
        label.text = "Приливной"
        return label
    }()

    private lazy var innerVerticalStackView: UIStackView = { [unowned self] in
        let stackView = UIStackView(arrangedSubviews: [self.sourceWordLabel, self.separator, self.targetWordLabel])
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.fill
        stackView.spacing = 4.0
        stackView.backgroundColor = #colorLiteral(red: 0.9182453156, green: 0.9182668328, blue: 0.9182552695, alpha: 1)

        self.separator.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.3).isActive = true
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.set(cornerRadius: 16)
        return stackView
    }()

    private lazy var verticalStackView: UIStackView = { [unowned self] in
        let stackView = UIStackView(arrangedSubviews: [self.titleLabel, self.innerVerticalStackView])
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.fill

        innerVerticalStackView.edgesToSuperview()

        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 5.0
        return stackView
    }()
}
