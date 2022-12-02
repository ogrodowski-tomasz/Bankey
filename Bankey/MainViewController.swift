//
//  MainViewController.swift
//  Bankey
//
//  Created by Tomasz Ogrodowski on 01/12/2022.
//

import UIKit

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupTabBar()
    }
    
    private func setupViews() {
        let summaryViewController = AccountSummaryViewController()
        let moneyViewController = MoveMoneyViewController()
        let moreViewController = MoreViewController()
        
        summaryViewController.setTabBarImage(imageName: "list.dash.header.rectangle", title: "Summary")
        moneyViewController.setTabBarImage(imageName: "arrow.left.arrow.right", title: "Move Money")
        moreViewController.setTabBarImage(imageName: "ellipsis.circle", title: "More")
        
        let summaryNavigationController = UINavigationController(rootViewController: summaryViewController)
        let moneyNavigationController = UINavigationController(rootViewController: moneyViewController)
        let moreNavigationController = UINavigationController(rootViewController: moreViewController)
        
        summaryNavigationController.navigationBar.barTintColor = appColor
        hideNavigationBarLine(summaryNavigationController.navigationBar)
        
        let tabBarList = [summaryNavigationController, moneyNavigationController, moreNavigationController]
        viewControllers = tabBarList
        
    }
    
    private func hideNavigationBarLine(_ navigationBar: UINavigationBar) {
        let image = UIImage()
        navigationBar.shadowImage = image
        navigationBar.setBackgroundImage(image, for: .default)
        navigationBar.isTranslucent = false
    }
    
    private func setupTabBar() {
        tabBar.tintColor = appColor
        tabBar.isTranslucent = false
    }
}

class AccountSummaryViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPurple
    }
}

class MoveMoneyViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
    }
}

class MoreViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemOrange
    }
}
