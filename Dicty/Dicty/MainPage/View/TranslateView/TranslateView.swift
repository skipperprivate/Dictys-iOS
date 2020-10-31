//
//  Copyright © 2020 Dictys. All rights reserved.
//

import TinyConstraints
import UIKit

protocol TranslateViewDelegate: AnyObject, UITextViewDelegate {
    func onSourceLanguageButtonTap()
    func onTargetLanguageButtonTap()
}

class TranslateView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setSubviewForAutoLayout(self.verticalStackView)

        verticalStackView.edgesToSuperview()
        self.set(cornerRadius: 16)

        sourceLanguageButton.addTarget(delegate, action: #selector(sourceLanguageButtonTapped), for: UIControl.Event.touchUpInside)
        targetLanguageButton.addTarget(delegate, action: #selector(targetLanguageButtonTapped), for: UIControl.Event.touchUpInside)
    }

    func resizeLabels() {
//        guard
//            let sourceFontSize = self.sourceLanguageButton.titleLabel?.getFontSizeForLabel(),
//            let targetFontSize = self.targetLanguageButton.titleLabel?.getFontSizeForLabel() else {
//            return
//        }
//
//        let smallestFontSize = min(sourceFontSize, targetFontSize)
//
//         self.sourceLanguageButton.titleLabel?.font = self.sourceLanguageButton.titleLabel?.font.withSize(smallestFontSize)
//        self.sourceLanguageButton.titleLabel?.adjustsFontSizeToFitWidth = false
//
//        self.targetLanguageButton.titleLabel?.font = self.targetLanguageButton.titleLabel?.font.withSize(smallestFontSize)
//        self.targetLanguageButton.titleLabel?.adjustsFontSizeToFitWidth = false
//        self.sourceLanguageButton.titleLabel?.adjustsFontSizeToFitWidth = false
//        self.sourceLanguageButton.setTitle("Русский", for: UIControl.State.normal)
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

    private var font: UIFont = {
        guard let font = UIFont(name: "AvenirNext-Regular", size: 16.0) else {
            return .init()
        }
        return font
    }()

    // MARK: Subviews
    lazy var sourceLanguageButton: UIButton = { [weak self] in
        guard let self = self else {
            return .init()
        }

        let button = UIButton(type: UIButton.ButtonType.system)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 16.0)
        button.setTitle(UDUtils.getSourceLang().name, for: UIControl.State.normal)
        button.setTitleColor(#colorLiteral(red: 0.2743373811, green: 0.2743446529, blue: 0.2743407488, alpha: 1), for: UIControl.State.normal)
        button.backgroundColor = .clear

        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 0.8

        button.set(cornerRadius: 5.0)
        return button
    }()

    lazy var targetLanguageButton: UIButton = { [weak self] in
        guard let self = self else {
            return .init()
        }

        let button = UIButton(type: UIButton.ButtonType.system)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 16.0)
        button.setTitle(UDUtils.getTargetLang().name, for: UIControl.State.normal)
        button.setTitleColor(#colorLiteral(red: 0.2743373811, green: 0.2743446529, blue: 0.2743407488, alpha: 1), for: UIControl.State.normal)
        button.backgroundColor = .clear

        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 0.8

        button.set(cornerRadius: 5.0)
        return button
    }()

    private let changeLanguagesButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        if #available(iOS 13.0, *) {
            button.setImage(UIImage(
                            systemName: "arrow.right.arrow.left.circle.fill"),
                            for: UIControl.State.normal)
        } else {
            button.setImage(#imageLiteral(resourceName: "SwitchLanguagesIcon"), for: UIControl.State.normal)
        }

        button.imageView?.contentMode = ContentMode.scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 4.0, left: 4.0, bottom: 4.0, right: 4.0)
        button.backgroundColor = .clear
        button.set(cornerRadius: 5.0)
        return button
    }()

    private lazy var horizontalStackView: UIStackView = { [weak self] in
        guard let self = self else {
            return .init()
        }
        let stackView = UIStackView(arrangedSubviews: [self.sourceLanguageButton, self.changeLanguagesButton, self.targetLanguageButton])

        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.fillEqually
        stackView.alignment = UIStackView.Alignment.fill
        stackView.spacing = 10.0
        stackView.layoutMargins = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
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
        //textView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return textView
    }()

    private lazy var sourceTextViewContainerView: UIView = {
        let view = UIView()
        let textViewFont = UIFont.systemFont(ofSize: 16)
        view.setSubviewForAutoLayout(sourceTextView)
        sourceTextView.edgesToSuperview(insets: .left(12) + .right(12))
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
        //textView.setContentHuggingPriority(.defaultLow, for: .vertical)
        return textView
    }()

    private lazy var translatedTextViewContainerView: UIView = {
        let view = UIView()
        let textViewFont = UIFont.systemFont(ofSize: 16)
        view.setSubviewForAutoLayout(translatedTextView)
        translatedTextView.edgesToSuperview(insets: .left(12) + .right(12))
        return view
    }()

    // MARK: Поле со словарем
    private let commonLabel: UILabel = {
        let label = UILabel()
        label.text = "Словарь"
        return label
    }()

    private let dictyImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "BookIcon")
        return imageView
    }()

    private let dictyLabel: UILabel = {
        let label = UILabel()
        label.text = "The Foghorn"
        return label
    }()

    private let arrImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        if #available(iOS 13.0, *) {
            imageView.image = UIImage(systemName: "chevron.right")
        } else {
            // Fallback on earlier versions
        }
        return imageView
    }()

    private lazy var commonHStackView: UIStackView = { [weak self] in
        guard let self = self else {
            return .init()
        }

        let stackView = UIStackView(arrangedSubviews: [self.commonLabel, dictyHorizontalStackView])

        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 10.0
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.layoutMargins = UIEdgeInsets(top: 5, left: 20, bottom: 10, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()

    private lazy var dictyHorizontalStackView: UIStackView = { [weak self] in
        guard let self = self else {
            return .init()
        }

        let stackView = UIStackView(arrangedSubviews: [self.dictyImage, self.dictyLabel, self.arrImage])

        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8.0

        return stackView
    }()

    // MARK: Сборка
    private lazy var verticalStackView: UIStackView = { [weak self] in
        guard let self = self else {
            return .init()
        }
        let stackView = UIStackView(arrangedSubviews: [
            self.horizontalStackView,
            createSeparator(),
            self.sourceTextViewContainerView,
            createSeparator(),
            self.translatedTextViewContainerView,
            createSeparator(),
            self.commonHStackView
        ])

        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.fill
        stackView.spacing = 5.0

        // не работает под ios 12 ?
        stackView.backgroundColor = #colorLiteral(red: 0.9182453156, green: 0.9182668328, blue: 0.9182552695, alpha: 1)

        sourceTextView.height(to: translatedTextView)

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
