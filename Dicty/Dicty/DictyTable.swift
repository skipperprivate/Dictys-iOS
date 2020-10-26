//
// Copyright © 2020 Dictys. All rights reserved.
//

import CoreData

extension Database {
    func fetchDictys() -> [DictyModel] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: T.Dictys.Table)

        do {
            return try managedContext.fetch(fetchRequest).compactMap { DictyModel(obj: $0) }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }

    func createDicty(newDicty: DictyModel) -> Bool {
        guard !newDicty.name.isEmpty else { return false }
        let entity = NSEntityDescription.entity(forEntityName: T.Dictys.Table, in: managedContext)!
        let dicty = NSManagedObject(entity: entity, insertInto: managedContext)

        dicty.setValue(newDicty.name, forKey: T.Dictys.Name)

        do {
            try managedContext.save()
            return true
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return false
        }
    }

    // Checks whether default dicty for that language exists
    func dictyLangExists(lang: TranslatorSupportedLanguage) -> Bool {
        guard let fullName = supportedLanguages.first(where: { $0.shortName == lang })?.name else {
            print("[FATAL ERROR] (Database.checkForLangDicty): supportedLanguages is out of sync with TranslatorSupportedLanguage")
            return false
        }

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: T.Dictys.Table)
        fetchRequest.predicate = NSPredicate(format: "%K == %@", T.Translates.SourceLang, fullName)

        do {
            let result = try managedContext.fetch(fetchRequest)
            if result.isEmpty {
                return createDicty(newDicty: DictyModel(fullName))
            } else {
                print(result)
                return true
            }
        } catch let error as NSError {
            print("Could not find language. \(error), \(error.userInfo)")
            return false
        }
    }
}
