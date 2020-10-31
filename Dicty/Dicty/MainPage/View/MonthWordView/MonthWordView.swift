//
// Copyright © 2020 Dictys. All rights reserved.
//

import TinyConstraints
import UIKit

class MonthWordView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setSubviewForAutoLayout(self.verticalStackView)
        verticalStackView.centerInSuperview()
        verticalStackView.heightToSuperview()
        verticalStackView.widthToSuperview()
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
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let sourceWordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Regular", size: 17.0)
        label.textColor = .black
        label.text = "Tidal"
        //label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        //label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let separator: UIView = {
        let separator = UIView()
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separator.backgroundColor = .black
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()

    private let targetWordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Regular", size: 17.0)
        label.textColor = #colorLiteral(red: 0.4240581393, green: 0.4240687788, blue: 0.4240630269, alpha: 1)
        label.text = "Приливной"
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let arrowImage: UIImageView = {
        let imageView = UIImageView()

        imageView.contentMode = .scaleAspectFit
        if #available(iOS 13.0, *) {
            imageView.image = UIImage(systemName: "chevron.right")
        } else {
            // Fallback on earlier versions
        }

        return imageView
    }()

    private lazy var newView: UIView = { [weak self] in
        guard let self = self else {
            return .init()
        }

        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9182453156, green: 0.9182668328, blue: 0.9182552695, alpha: 1)
        view.addSubview(innerHorizontalStackView)
        innerHorizontalStackView.edgesToSuperview(insets: .left(20) + .top(10) + .bottom(10) + .right(20))
        view.set(cornerRadius: 16)
        return view
    }()

    private lazy var innerHorizontalStackView: UIStackView = { [weak self] in
        guard let self = self else {
            return .init()
        }
        let stackView = UIStackView(arrangedSubviews: [self.innerVerticalStackView, self.arrowImage])

        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.leading
        stackView.spacing = 5.0

        innerVerticalStackView.edgesToSuperview(excluding: .trailing)
        arrowImage.edgesToSuperview(excluding: .leading)

        return stackView
    }()

    private lazy var innerVerticalStackView: UIStackView = { [weak self] in
        guard let self = self else {
            return .init()
        }
        let stackView = UIStackView(arrangedSubviews: [self.sourceWordLabel, self.separator, self.targetWordLabel])
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.leading
        stackView.spacing = 2.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        separator.widthToSuperview(multiplier: 0.4)
        return stackView
    }()

    private lazy var verticalStackView: UIStackView = { [weak self] in
        guard let self = self else {
            return .init()
        }
        let stackView = UIStackView(arrangedSubviews: [self.titleLabel, self.newView])
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 0.0
        stackView.translatesAutoresizingMaskIntoConstraints = false

        newView.leftToSuperview()
        newView.rightToSuperview()
        return stackView
    }()
}
