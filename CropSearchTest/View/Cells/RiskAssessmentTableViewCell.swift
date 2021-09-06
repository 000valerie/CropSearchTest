//
//  RiskAssessmentTableViewCell.swift
//  CropSearchTest
//
//  Created by ler on 9/6/21.
//

import Foundation
import UIKit

protocol RiskAssessmentTableViewCellDelegate: AnyObject {
    func onCommentButtonPress(_ indexPath: IndexPath)
}

final class RiskAssessmentTableViewCell: UITableViewCell {

    private var titleLabel: UILabel = UILabel()
    private var commentButton: UIButton = UIButton()
    private var statusSegmentedControl: UISegmentedControl = UISegmentedControl(items: ["Acceptable", "Unacceptable", "N/A"])
    private var commentTextField: UITextField = UITextField()
    private var indexPath: IndexPath = IndexPath(row: 0, section: 0)

    weak var delegate: RiskAssessmentTableViewCellDelegate?

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

        contentView.addSubview(titleLabel)

        commentButton.addTarget(self, action: #selector(onCommentButtonPress), for: .touchUpInside)
        contentView.addSubview(commentButton)

        statusSegmentedControl.addTarget(self, action: #selector(onSegmentedControlChange), for: .valueChanged)
        contentView.addSubview(statusSegmentedControl)

        commentTextField.borderStyle = .roundedRect
        contentView.addSubview(commentTextField)

        setupConstraints()
    }

    func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = false

        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(greaterThanOrEqualTo: commentButton.leadingAnchor, constant: 8).isActive = true
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        commentButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        commentButton.trailingAnchor.constraint(equalTo: statusSegmentedControl.leadingAnchor, constant: -16).isActive = true
        commentButton.translatesAutoresizingMaskIntoConstraints = false

        statusSegmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        statusSegmentedControl.centerYAnchor.constraint(equalTo: commentButton.centerYAnchor).isActive = true
        statusSegmentedControl.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3).isActive = true
        statusSegmentedControl.translatesAutoresizingMaskIntoConstraints = false

        commentTextField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        commentTextField.trailingAnchor.constraint(equalTo: statusSegmentedControl.trailingAnchor).isActive = true
        commentTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        commentTextField.translatesAutoresizingMaskIntoConstraints = false
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
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
    }

    @objc func onCommentButtonPress(_ button: UIButton) {
        delegate?.onCommentButtonPress(indexPath)
    }
}

extension RiskAssessmentTableViewCell {
    enum Status: Int {
        case acceptable, unacceptable
        case notApplicable
    }

    struct Model {
        let title: String
        var isExtended: Bool
        var status: Status?
        let indexPath: IndexPath
    }
}

extension RiskAssessmentTableViewCell {
    func configure(with model: Model) {
        titleLabel.text = model.title

        indexPath = model.indexPath
        backgroundColor = indexPath.row % 2 == 1 ? .secondarySystemBackground : .systemBackground

        commentButton.setImage(model.isExtended ? .remove : .add, for: .normal)
        commentTextField.isHidden = !model.isExtended

        if let status = model.status {
            statusSegmentedControl.selectedSegmentIndex = status.rawValue
            onSegmentedControlChange(statusSegmentedControl)
        }
    }
}
