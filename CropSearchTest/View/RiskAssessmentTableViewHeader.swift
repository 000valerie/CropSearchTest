//
//  RiskAssessmentTableViewHeader.swift
//  CropSearchTest
//
//  Created by ler on 9/6/21.
//

import Foundation
import UIKit

final class RiskAssessmentTableViewHeader: UITableViewHeaderFooterView {
    private var titleLabel: UILabel = UILabel()
    private var customBackgroundView: UIView = UIView()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
}

private extension RiskAssessmentTableViewHeader {
    func setupView() {
        contentView.addSubview(customBackgroundView)
        titleLabel.textColor = .white
        contentView.addSubview(titleLabel)
        setupConstraints()
    }

    func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = false

        customBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        customBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        customBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        customBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        customBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor, constant: -16).isActive = true
    }
}

extension RiskAssessmentTableViewHeader {
    struct Model {
        let title: String
        var isValid: Bool
    }
}

extension RiskAssessmentTableViewHeader {
    func configure(with model: Model) {
        titleLabel.text = model.title
        customBackgroundView.backgroundColor = model.isValid ? .systemGreen : .systemGray
    }
}
