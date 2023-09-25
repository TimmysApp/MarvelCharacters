//
//  PersistenceControllerStub.swift
//  Marvel CharactersTests
//
//  Created by Joe Maghzal on 23/09/2023.
//

import CoreData
@testable import Marvel_Characters

struct PersistenceControllerStub {
    let container: NSPersistentContainer
    init() {
        container = NSPersistentContainer(name: "Marvel_Characters")
        container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
