//
//  TabBarController.swift
//  CropSearchTest
//
//  Created by ler on 9/3/21.
//

import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        navigationItem.largeTitleDisplayMode = .always
    }

    func setupUI() {
        let firstViewController: UIViewController = ViewController()
        firstViewController.tabBarItem = UITabBarItem(title: "Dashboard", image: nil, tag: 0)

        let secondViewController: UIViewController = RiskAssessmentsTableViewController()
        secondViewController.title = "Cooler Facility Risk Assessment"

        let documentViewController: UIViewController = ViewController()
        documentViewController.title = "Documents"

        let navigationController: UINavigationController = UINavigationController()
        navigationController.setViewControllers([documentViewController, secondViewController], animated: false)
        navigationController.tabBarItem = UITabBarItem(title: "Food Safety", image: nil, tag: 1)

        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.setToolbarHidden(false, animated: false)

        let tabBarList = [firstViewController, navigationController]
        viewControllers = tabBarList

        selectedIndex = 1
    }
}
