//
//  Character.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 22/09/2023.
//

import Foundation
import DataStruct

typealias CollectionElement = Identifiable & Equatable & Hashable

struct Character: CollectionElement {
    var id: Int?
    var name: String
    var description: String
    var thumbnailPath: String?
    var thumbnailURL: URL? {
        guard let thumbnailPath else {
            return nil
        }
        return URL(string: thumbnailPath.replacingOccurrences(of: "http", with: "https"))
    }
    var additionalLinks: [AdditionalLink]
}

//MARK: - Datable
extension Character: Datable {
    static let modelData = ModelData<Character>()
    static var dataKeys = ["description": "characterDescription"]
    static func map(from object: CharacterData?) -> Character? {
        guard let object else {
            return nil
        }
        return Character(id: Int(object.oid), name: object.name ?? "", description: object.characterDescription ?? "", thumbnailPath: object.thumbnailPath, additionalLinks: object.additionalLinks?.model() ?? [])
    }
}
