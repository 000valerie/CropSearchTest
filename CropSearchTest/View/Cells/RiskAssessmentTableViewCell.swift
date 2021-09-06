//
//  RiskAssessmentTableViewCell.swift
//  CropSearchTest
//
//  Created by ler on 9/6/21.
//

import Foundation
import UIKit

final class RiskAssessmentTableViewCell: UITableViewCell {

    private var titleLabel: UILabel = UILabel()
    private var commentButton: UIButton = UIButton()
    private var statusSegmentedControl: UISegmentedControl = UISegmentedControl(items: ["Acceptable", "Unacceptable", "N/A"])
    private var commentTextField: UITextField = UITextField()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
}

private extension RiskAssessmentTableViewCell {
    func setupView() {
        selectionStyle = .none

        addSubview(titleLabel)

        addSubview(commentButton)

        statusSegmentedControl.addTarget(self, action: #selector(onSegmentedControlChange), for: .valueChanged)
        addSubview(statusSegmentedControl)

        addSubview(commentTextField)

        setupConstraints()
    }

    func setupConstraints() {
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(greaterThanOrEqualTo: commentButton.leadingAnchor, constant: 8).isActive = true

        commentButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        commentButton.trailingAnchor.constraint(equalTo: statusSegmentedControl.leadingAnchor, constant: 32).isActive = true
        commentButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        commentButton.widthAnchor.constraint(equalToConstant: 20).isActive = true

        statusSegmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 16).isActive = true
        statusSegmentedControl.centerYAnchor.constraint(equalTo: commentButton.centerYAnchor).isActive = true

        commentTextField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        commentButton.trailingAnchor.constraint(equalTo: statusSegmentedControl.trailingAnchor).isActive = true
        commentTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
    }

    @objc func onSegmentedControlChange(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            segmentedControl.selectedSegmentTintColor = .systemGreen
        case 1:
            segmentedControl.selectedSegmentTintColor = .systemRed
        case 2:
            segmentedControl.selectedSegmentTintColor = .systemGray2
        default:
            break
        }
    }
}

extension RiskAssessmentTableViewCell {
    enum Appearance {
        case basic, extended
    }

    enum Status {
        case acceptable, unacceptable
        case notApplicable
    }

    struct Model {
        let title: String
        let appearance: Appearance
        let status: Status?
    }
}

extension RiskAssessmentTableViewCell {
    func configure(with model: Model) {
        titleLabel.text = model.title

        switch model.appearance {
        case .basic:
            commentButton.setImage(UIImage(named: ""), for: .normal)
            commentTextField.isHidden = true
        case .extended:
            commentButton.setImage(UIImage(named: ""), for: .normal)
            commentTextField.isHidden = false
        }
    }
}
