//
//  CharactersLocalSource.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 23/09/2023.
//

import Foundation
import CoreData
import DataStruct

protocol CharactersLocalSource {
    func fetch() async throws -> [Character]
    func update(using data: [Character]) async throws
}

struct CharactersDatabase {
    let objectContext: NSManagedObjectContext
    init(objectContext: NSManagedObjectContext) {
        self.objectContext = objectContext
    }
}

//MARK: - CharactersLocalSource
extension CharactersDatabase: CharactersLocalSource {
    func fetch() async throws -> [Character] {
        let characters = try Character.fetch(objectContext: objectContext)
        return characters
    }
    func update(using data: [Character]) async throws {
        let oldData = try await fetch()
        objectContext.performAndWait {
            oldData.forEach { character in
                character.delete(objectContext)
            }
            data.forEach { character in
                character.save(objectContext)
            }
        }
    }
}
