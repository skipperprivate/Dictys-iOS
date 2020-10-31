//
//  Copyright © 2020 Dictys. All rights reserved.
//

import UIKit

class DictysTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let mainPageViewController = MainPageViewController()
        mainPageViewController.tabBarItem = UITabBarItem(title: "Новое слово", image: #imageLiteral(resourceName: "􀈌"), tag: 0)

        let settingsViewController = SettingsViewController()
        settingsViewController.tabBarItem = UITabBarItem(title: "Активность", image: #imageLiteral(resourceName: "􀤑"), tag: 1)
    

        let dictysViewController: DictysViewController? = {
            let storyboard = UIStoryboard(name: "Dictys", bundle: Bundle.main)
            let dictysViewController = storyboard.instantiateViewController(withIdentifier: "DictysViewController") as? DictysViewController
            return dictysViewController
        }()
        dictysViewController?.tabBarItem = UITabBarItem(title: "Словари", image: #imageLiteral(resourceName: "􀤟"), tag: 2)

        let tabBarList = [settingsViewController, mainPageViewController, dictysViewController].compactMap { $0 }

        self.viewControllers = tabBarList
        self.selectedIndex = 1
        self.tabBar.tintColor = UIColor.black
    }
}
