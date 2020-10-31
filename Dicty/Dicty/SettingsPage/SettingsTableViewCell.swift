//
//  SettingsTableViewCell.swift
//  Dicty
//
//  Created by Владислав Ледащев on 31.10.2020.
//  Copyright © 2020 Dictys. All rights reserved.
//

import UIKit
import TinyConstraints

class SettingsTableViewCell: UITableViewCell {
//  override func setSelected(_ selected: Bool, animated: Bool) {
//      super.setSelected(selected, animated: animated)

//      // Configure the view for the selected state
//  }
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Label"
        label.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.0, *) {
            label.backgroundColor = .clear
        } else {
            self.backgroundColor = .clear
        }
        return label
    }()
    lazy var pictureView: UIImageView = {
        let pictureView = UIImageView()
        pictureView.image = #imageLiteral(resourceName: "Korean")
        pictureView.contentMode = .scaleAspectFit
        return pictureView
    }()
    private lazy var innerHorizontalStackView: UIStackView = { [weak self] in
        guard let self = self else {
            return .init()
        }
        let stackView = UIStackView(arrangedSubviews: [ self.pictureView, self.label])

        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.fillProportionally
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 5.0

        pictureView.edgesToSuperview(excluding: .trailing)
        label.edgesToSuperview(excluding: .leading)

        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        if #available(iOS 13.0, *) {
            self.backgroundColor = .clear
        } else {
            self.backgroundColor = .clear
        }
        self.addSubview(innerHorizontalStackView)
        innerHorizontalStackView.edgesToSuperview(insets: .left(20) + .right(20) + .bottom(5) + .top(5))
        self.accessoryType = .disclosureIndicator
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
