//
//  CharacterDetailsLocalSource.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 24/09/2023.
//

import Foundation
import CoreData
import DataStruct

protocol CharacterDetailsLocalSource {
    func fetch(for characterID: Int, type: CharacterContent.ContentType) async throws -> [CharacterContent]
    func update(using data: [CharacterContent], for characterID: Int, type: CharacterContent.ContentType) async throws
}

struct CharacterDetailsDatabase {
    let objectContext: NSManagedObjectContext
    init(objectContext: NSManagedObjectContext) {
        self.objectContext = objectContext
    }
}

//MARK: - CharacterDetailsLocalSource
extension CharacterDetailsDatabase: CharacterDetailsLocalSource {
    func fetch(for characterID: Int, type: CharacterContent.ContentType) async throws -> [CharacterContent] {
        let content = try CharacterContent.fetch(with: NSPredicate(format: "characterID == %@ && type == %@", String(characterID), String(type.rawValue)), objectContext: objectContext)
        return content
    }
    func update(using data: [CharacterContent], for characterID: Int, type: CharacterContent.ContentType) async throws {
        let oldData = try await fetch(for: characterID, type: type)
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
