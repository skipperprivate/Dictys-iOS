//
// Copyright © 2020 Dictys. All rights reserved.
//

import CoreData

extension Database {
    func createTranslate(newTranslate: TranslateModel) -> Bool {
        guard newTranslate.original.isEmpty ||
              newTranslate.translated.isEmpty else { return false }

        if !dictyLangExists(lang: newTranslate.originalLang) { return false }
        
        let entity = NSEntityDescription.entity(forEntityName: T.Translates.Table, in: managedContext)!
        let translate = NSManagedObject(entity: entity, insertInto: managedContext)

        translate.setValuesForKeys(
            [
                T.Translates.Original: newTranslate.original,
                T.Translates.Translated: newTranslate.translated,
                T.Translates.OriginalLang: newTranslate.originalLang,
                T.Translates.TranslatedLang: newTranslate.transatedLang
            ])

        do {
            try managedContext.save()
            return true
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return false
        }
    }

    func fetchTranslates() -> [TranslateModel] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: T.Translates.Table)

        do {
            return try managedContext.fetch(fetchRequest).compactMap { TranslateModel(obj: $0) }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
}
