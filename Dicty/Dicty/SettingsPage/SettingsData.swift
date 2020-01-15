//
//  SettingsData.swift
//  Dicty
//
//  Created by Егор Бедов on 12/01/2020.
//  Copyright © 2020 Егор Бедов. All rights reserved.
//

import UIKit

struct Settings {
    var title: String
    var fields: [SettingField]
}

struct SettingField {
    var title: String
    var icon: UIImage?
//    var palettes = [UIImage]?
}

extension Settings {
    static var allSettings: [Settings] {
        return [
            Settings(title: "General",
                     fields: [SettingField(title: "Interface language",
                                           icon: UIImage(named: "GlobeIcon")),
                              SettingField(title: "Offline dictionaries",
                                           icon: UIImage(named: "DownloadsIcon")),]),
            Settings(title: "Personal",
                     fields: [SettingField(title: "Profile",
                                           icon: UIImage(named: "ProfileIcon")),
                              SettingField(title: "Stats",
                                           icon: UIImage(named: "StatsIcon"))]),
            Settings(title: "Interface",
                     fields: [SettingField(title: "Light mode",
                                           icon: UIImage(named: "SunIcon")),
                              SettingField(title: "Dark mode",
                                           icon: UIImage(named: "MoonIcon")),
                              SettingField(title: "Auto-night mode",
                                           icon: UIImage(named: "SunsetIcon"))]),
            Settings(title: "Additional",
                     fields: [SettingField(title: "About",
                                           icon: UIImage(named: "InfoIcon")),
                              SettingField(title: "Text developer",
                                           icon: UIImage(named: "ChatIcon"))])
        ]
    }
}
