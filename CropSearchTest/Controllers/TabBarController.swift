//
//  TabBarController.swift
//  CropSearchTest
//
//  Created by ler on 9/3/21.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    func setupUI() {
        let firstViewController: UIViewController = ViewController()
        firstViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .mostViewed, tag: 0)
        let secondViewController: UIViewController = CoolerFacilityRiskAssessments()
        secondViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 1)
        let tabBarList = [firstViewController, secondViewController]
        viewControllers = tabBarList

        selectedIndex = 1
    }
}
