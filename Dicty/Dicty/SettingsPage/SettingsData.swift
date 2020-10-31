//
//  Copyright © 2020 Dictys. All rights reserved.
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
            Settings(title: "Основные",
                     fields: [SettingField(title: "Язык интерфейса",
                                           icon: UIImage(named: "GlobeIcon")),
                              SettingField(title: "Загруженные словари",
                                           icon: UIImage(named: "DownloadsIcon"))]),
            Settings(title: "Личное",
                     fields: [SettingField(title: "Профиль",
                                           icon: UIImage(named: "ProfileIcon")),
                              SettingField(title: "Статистика",
                                           icon: UIImage(named: "StatsIcon"))]),
            Settings(title: "Интерфейс",
                     fields: [SettingField(title: "Светлая тема",
                                           icon: UIImage(named: "SunIcon")),
                              SettingField(title: "Тёмная тема",
                                           icon: UIImage(named: "MoonIcon")),
                              SettingField(title: "Автоматический режим",
                                           icon: UIImage(named: "SunsetIcon"))]),
            Settings(title: "Дополнительно",
                     fields: [SettingField(title: "О приложении",
                                           icon: UIImage(named: "InfoIcon")),
                              SettingField(title: "Связаться с разработчиком",
                                           icon: UIImage(named: "ChatIcon"))])
        ]
    }
}
