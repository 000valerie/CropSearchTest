//
//  RiskAssessmentsTableViewController.swift
//  CropSearchTest
//
//  Created by ler on 9/2/21.
//

import Foundation
import UIKit

final class RiskAssessmentsTableViewController: UITableViewController {

    private var items: [RiskAssessmentTableViewCell.Model] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RiskAssessmentTableViewCell.self, forCellReuseIdentifier: "RiskAssessmentTableViewCell")
        tableView.register(RiskAssessmentTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "RiskAssessmentTableViewHeader")
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none

        demo()

        view.backgroundColor = UIColor.systemBackground
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let leftButton: UIBarButtonItem = UIBarButtonItem(title: "Save Changes", style: .plain, target: self, action: nil)
        let rightButton: UIBarButtonItem = UIBarButtonItem(title: "Final Submit", style: .plain, target: self, action: nil)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)

        navigationController?.toolbar.items = [flexibleSpace, leftButton, flexibleSpace, rightButton, flexibleSpace]
    }
}

extension RiskAssessmentsTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RiskAssessmentTableViewCell", for: indexPath) as? RiskAssessmentTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: items[indexPath.row])
        cell.delegate = self

        return cell
    }
}

extension RiskAssessmentsTableViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return items[indexPath.row].isExtended ? 100.0 : 50.0
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "RiskAssessmentTableViewHeader") as? RiskAssessmentTableViewHeader
        let isValid: Bool = items.filter { $0.status != nil }.count == items.count
        headerView?.configure(with: RiskAssessmentTableViewHeader.Model(title: "Areas of observation - please note concern(s) if any, as well as corrective action(s)", isValid: isValid))
        return headerView
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45.0
    }
}

extension RiskAssessmentsTableViewController: RiskAssessmentTableViewCellDelegate {
    func onCommentButtonPress(_ indexPath: IndexPath) {
        items[indexPath.row].isExtended.toggle()
        tableView.reloadData()
    }

    func onStatusSegmentedControlChange(_ indexPath: IndexPath, status: Int) {
        let currentStatus: Int? = items[indexPath.row].status?.rawValue
        if currentStatus != status {
            items[indexPath.row].status = RiskAssessmentTableViewCell.Status(rawValue: status)
            tableView.reloadData()
        }
    }
}

private extension RiskAssessmentsTableViewController {
    func demo() {
        items = [
            RiskAssessmentTableViewCell.Model(title: "Surrounding Areas / Adjacent Activities", isExtended: false, status: nil, indexPath: IndexPath(row: 0, section: 0)),
            RiskAssessmentTableViewCell.Model(title: "Building Grounds", isExtended: false, status: nil, indexPath: IndexPath(row: 1, section: 0)),
            RiskAssessmentTableViewCell.Model(title: "Building Structure", isExtended: true, status: .unacceptable, indexPath: IndexPath(row: 2, section: 0)),
            RiskAssessmentTableViewCell.Model(title: "Water System", isExtended: false, status: nil, indexPath: IndexPath(row: 3, section: 0)),
            RiskAssessmentTableViewCell.Model(title: "Other", isExtended: false, status: nil, indexPath: IndexPath(row: 4, section: 0))
        ]

    }
}
