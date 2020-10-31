//
//  Copyright © 2020 Dictys. All rights reserved.
//

import UIKit

class DictysTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let mainPageViewController = MainPageViewController()
        mainPageViewController.tabBarItem = UITabBarItem(title: "New word", image: #imageLiteral(resourceName: "PencilIcon"), tag: 0)

        let settingsViewController = SettingsViewController()
        settingsViewController.tabBarItem = UITabBarItem(title: "Settings", image: #imageLiteral(resourceName: "GearIcon"), tag: 1)

        let dictysViewController: DictysViewController? = {
            let storyboard = UIStoryboard(name: "Dictys", bundle: Bundle.main)
            let dictysViewController = storyboard.instantiateViewController(withIdentifier: "DictysViewController") as? DictysViewController
            return dictysViewController
        }()
        dictysViewController?.tabBarItem = UITabBarItem(title: "Dictys", image: #imageLiteral(resourceName: "BookIcon"), tag: 2)

        let tabBarList = [mainPageViewController, settingsViewController, dictysViewController].compactMap { $0 }
        self.viewControllers = tabBarList
    }
}
