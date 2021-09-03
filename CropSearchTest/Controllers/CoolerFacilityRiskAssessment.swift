//
//  CoolerFacilityRiskAssessment.swift
//  CropSearchTest
//
//  Created by ler on 9/2/21.
//

import Foundation
import UIKit

final class CoolerFacilityRiskAssessments: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
