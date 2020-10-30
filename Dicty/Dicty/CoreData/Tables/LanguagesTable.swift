//
//  Copyright © 2020 Dictys. All rights reserved.
//

import CoreData

extension Database {
    func insertDefaultLanguages() {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: T.Languages.Table)

        do {
            let amount = try managedContext.count(for: fetchRequest)
            if amount != 0 { return }
        } catch let error as NSError {
            print("Could not count languages. \(error), \(error.userInfo)")
            return
        }

        for lang in supportedLanguages {
            let entity = NSEntityDescription.entity(forEntityName: T.Languages.Table, in: managedContext)!
            let translate = NSManagedObject(entity: entity, insertInto: managedContext)

            translate.setValuesForKeys(
                [
                    T.Languages.Name: lang.name,
                    T.Languages.Id: lang.id,
                    T.Languages.ShortName: lang.shortName.rawValue
                ])
        }

        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not insert default languages. \(error), \(error.userInfo)")
        }
    }

    func fetchLanguages() -> [LanguageModel] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: T.Languages.Table)

        do {
            return try managedContext.fetch(fetchRequest).compactMap { LanguageModel(obj: $0) }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
}
