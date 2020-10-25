//
//  Copyright © 2020 Dictys. All rights reserved.
//

import UIKit
import TinyConstraints

protocol TranslateViewDelegate: AnyObject, UITextViewDelegate {
    func onSourceLanguageButtonTap()
    func onTargetLanguageButtonTap()
}

class TranslateView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setSubviewForAutoLayout(self.verticalStackView)

        //verticalStackView.edgesToSuperview()

        self.backgroundColor = #colorLiteral(red: 0.9182453156, green: 0.9182668328, blue: 0.9182552695, alpha: 1)
        self.set(cornerRadius: 16)

        sourceLanguageButton.addTarget(delegate, action: #selector(sourceLanguageButtonTapped), for: UIControl.Event.touchUpInside)
        targetLanguageButton.addTarget(delegate, action: #selector(targetLanguageButtonTapped), for: UIControl.Event.touchUpInside)
    }

    weak var delegate: TranslateViewDelegate? {
        didSet {
            sourceTextView.delegate = delegate
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createSeparator() -> UIView {
        let separator = UIView()
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separator.backgroundColor = #colorLiteral(red: 0.8110396266, green: 0.8110588193, blue: 0.8110484481, alpha: 1)
        return separator
    }

    // MARK: Subviews
    private let sourceLanguageButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 16.0)
        button.setTitle("Русский", for: UIControl.State.normal)
        button.setTitleColor(#colorLiteral(red: 0.2743373811, green: 0.2743446529, blue: 0.2743407488, alpha: 1), for: UIControl.State.normal)
        button.backgroundColor = .clear
        button.set(cornerRadius: 5.0)
        return button
    }()

    private let targetLanguageButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 16.0)
        button.setTitle("Английский", for: UIControl.State.normal)
        button.setTitleColor(#colorLiteral(red: 0.2743373811, green: 0.2743446529, blue: 0.2743407488, alpha: 1), for: UIControl.State.normal)
        button.backgroundColor = .clear
        button.set(cornerRadius: 5.0)
        return button
    }()

    private let changeLanguagesButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.setImage(UIImage(systemName: "arrow.right.arrow.left.circle.fill"), for: UIControl.State.normal)
        button.backgroundColor = .clear
        button.set(cornerRadius: 5.0)
        return button
    }()

    private lazy var horizontalStackView: UIStackView = { [unowned self] in
        let stackView = UIStackView(arrangedSubviews: [self.sourceLanguageButton, self.changeLanguagesButton, self.targetLanguageButton])
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.fillEqually
        stackView.alignment = UIStackView.Alignment.fill
        stackView.spacing = 10.0
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()

    lazy var sourceTextView: UITextView = {
        let textViewFont = UIFont.systemFont(ofSize: 16)
        let textViewText = TranslateViewPlaceholders.sourceTextPlaceholder.rawValue
        let textView = UITextView()
        textView.font = textViewFont
        textView.text = textViewText
        textView.textColor = #colorLiteral(red: 0.5217987895, green: 0.5218115449, blue: 0.52180475, alpha: 1)
        textView.isScrollEnabled = true
        textView.backgroundColor = .clear
        return textView
    }()

    private lazy var sourceTextViewContainerView: UIView = {
        let view = UIView()
        let textViewFont = UIFont.systemFont(ofSize: 16)
        view.setSubviewForAutoLayout(sourceTextView)
        sourceTextView.edgesToSuperview(excluding: .none, insets: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20), relation: .equal, priority: .defaultHigh, isActive: true, usingSafeArea: true)
        sourceTextView.height(100)
        return view
    }()

    lazy var translatedTextView: UITextView = {
        let textViewFont = UIFont.systemFont(ofSize: 16)
        let textViewText = TranslateViewPlaceholders.translatedTextPlaceholder.rawValue
        let textView = UITextView()
        textView.font = textViewFont
        textView.text = textViewText
        textView.textColor = #colorLiteral(red: 0.5217987895, green: 0.5218115449, blue: 0.52180475, alpha: 1)
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.backgroundColor = .clear
        return textView
    }()

    private lazy var translatedTextViewContainerView: UIView = {
        let view = UIView()
        let textViewFont = UIFont.systemFont(ofSize: 16)
        view.setSubviewForAutoLayout(translatedTextView)
        translatedTextView.edgesToSuperview(excluding: .none, insets: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20), relation: .equal, priority: .defaultHigh, isActive: true, usingSafeArea: true)
        translatedTextView.height(100)
        return view
    }()

    private lazy var verticalStackView: UIStackView = { [unowned self] in
        let stackView = UIStackView(arrangedSubviews: [
            self.horizontalStackView,
            createSeparator(),
            self.sourceTextViewContainerView,
            createSeparator(),
            self.translatedTextViewContainerView,
            createSeparator()
        ])
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.fillProportionally
        stackView.alignment = UIStackView.Alignment.fill
        stackView.spacing = 10.0

        return stackView
    }()
}

extension TranslateView {
    @objc func sourceLanguageButtonTapped() {
        delegate?.onSourceLanguageButtonTap()
    }

    @objc func targetLanguageButtonTapped() {
        delegate?.onTargetLanguageButtonTap()
    }
}
