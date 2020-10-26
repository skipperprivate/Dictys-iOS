//
// Copyright © 2020 Dictys. All rights reserved.
//

import CoreData

class Database {
    static var shared = Database()

    private init() {}

    lazy var container: NSPersistentContainer = {
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

    func populate() {
        insertDefaultLanguages()
    }

    // MARK: Delete funcs
    func cleanUserStorage() {
        for entityName in T.UserTables {
            deleteEntityInstances(entityName: entityName)
        }
    }

    func purge() {
        for entityName in T.DefaultTables {
            deleteEntityInstances(entityName: entityName)
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
