//
//  Persistence.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 22/09/2023.
//

import CoreData

struct PersistenceController {
//MARK: - Properties
    static var shared = PersistenceController()
    let container: NSPersistentContainer
    private var backgroundContext: NSManagedObjectContext?
//MARK: - Initializer
    init(inMemory: Bool = false) {
        let storeName = "Marvel_Characters"
        let appGroup = "{{AppGrpup}}"
        container = NSPersistentContainer(name: storeName)
        if let storeURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroup)?.appendingPathComponent("\(storeName).sqlite") {
            container.persistentStoreDescriptions = [NSPersistentStoreDescription(url: storeURL)]
        }else {
            print("Could not find app group")
        }
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
//MARK: - Functions
    mutating func mainBackgroundContext() -> NSManagedObjectContext {
        if let backgroundContext {
            return backgroundContext
        }
        let newContext = container.newBackgroundContext()
        backgroundContext = newContext
        return newContext
    }
}
