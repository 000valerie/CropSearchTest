//
//  CoolerFacilityRiskAssessment.swift
//  CropSearchTest
//
//  Created by ler on 9/2/21.
//

import Foundation
import UIKit

final class CoolerFacilityRiskAssessments: UITableViewController {

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

extension CoolerFacilityRiskAssessments {
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

extension CoolerFacilityRiskAssessments {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return items[indexPath.row].isExtended ? 100.0 : 50.0
    }
}

extension CoolerFacilityRiskAssessments: RiskAssessmentTableViewCellDelegate {
    func onCommentButtonPress(_ indexPath: IndexPath) {
        items[indexPath.row].isExtended.toggle()
        tableView.reloadData()
    }
}

private extension CoolerFacilityRiskAssessments {
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
