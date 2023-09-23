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
    func fetch(using parameters: CharactersParameters) async throws -> [Character]
    func update(using data: [Character]) async throws
}

class CharactersDatabase {
    private var fetchedCharacters = [Character]()
    let objectContext: NSManagedObjectContext
    init(objectContext: NSManagedObjectContext) {
        self.objectContext = objectContext
    }
}

//MARK: - CharactersLocalSource
extension CharactersDatabase: CharactersLocalSource {
    func fetch(using parameters: CharactersParameters) async throws -> [Character] {
        let characters = try Character.fetch(objectContext: objectContext)
        fetchedCharacters = characters
        return characters
    }
    func update(using data: [Character]) async throws {
        fetchedCharacters.forEach { character in
            character.delete(objectContext)
        }
        data.forEach { character in
            character.save(objectContext)
        }
    }
}
