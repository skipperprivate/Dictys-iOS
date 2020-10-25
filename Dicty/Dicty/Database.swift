//
// Copyright © 2020 Dictys. All rights reserved.
//

import CoreData

class Database {
    public lazy var container: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: T.ModelName)
        container.loadPersistentStores(completionHandler: { storeDescription, error in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                print("Unresolved error \(error), \(error.userInfo) for store \(storeDescription)")
            }
        })
        return container
    }()

    lazy var managedContext: NSManagedObjectContext = {
        return self.container.viewContext
    }()

    lazy var coordinator: NSPersistentStoreCoordinator = {
        return self.container.persistentStoreCoordinator
    }()

    func saveContext() {
        guard managedContext.hasChanges else { return }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Error: \(error), \(error.userInfo)")
        }
    }

    // MARK: Fetch Funcs
    public func fetchDictys() -> [DictyModel] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: T.Dictys.Table)

        do {
            return try managedContext.fetch(fetchRequest).compactMap { DictyModel(obj: $0) }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }

    public func fetchTranslates() -> [TranslateModel] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: T.Translates.Table)

        do {
            return try managedContext.fetch(fetchRequest).compactMap { TranslateModel(obj: $0) }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }

    public func fetchLanguages() -> [LanguageModel] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: T.Languages.Table)

        do {
            return try managedContext.fetch(fetchRequest).compactMap { LanguageModel(obj: $0) }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }

    // MARK: Insert funcs
    public func createDicty(name: String) -> Bool {
        guard !name.isEmpty else { return false }
        let entity = NSEntityDescription.entity(forEntityName: T.Dictys.Table, in: managedContext)!
        let dicty = NSManagedObject(entity: entity, insertInto: managedContext)

        dicty.setValue(name, forKeyPath: T.Dictys.Name)

        do {
            try managedContext.save()
            return true
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return false
        }
    }

    public func createTranslate(original orig: String, translated trans: String) -> Bool {
        guard !orig.isEmpty,
              !trans.isEmpty else { return false }
        // TODO: insert dicty with trans lang if not exists
        let entity = NSEntityDescription.entity(forEntityName: T.Translates.Table, in: managedContext)!
        let translate = NSManagedObject(entity: entity, insertInto: managedContext)

        translate.setValuesForKeys([ T.Translates.Original: orig, T.Translates.Translated: trans ])

        do {
            try managedContext.save()
            return true
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return false
        }
    }

    public func populate() {
        self.insertDefaultLanguages()
    }

    private func insertDefaultLanguages() {
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

            translate.setValuesForKeys([ T.Languages.Name: lang.name, T.Languages.Id: lang.id ])
        }

        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not insert default languages. \(error), \(error.userInfo)")
        }
    }

    // MARK: Delete funcs
    public func cleanUserStorage() {
        for entityName in T.UserTables {
            self.deleteEntityInstances(entityName: entityName)
        }
    }

    public func purge() {
        for entityName in T.DefaultTables {
            self.deleteEntityInstances(entityName: entityName)
        }
    }

    private func deleteEntityInstances(entityName: String) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try coordinator.execute(deleteRequest, with: managedContext)
        } catch let error as NSError {
            print("Failed to clean \(entityName). \(error), \(error.userInfo)")
        }
    }
}
