//
//  CharacterContent.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 24/09/2023.
//

import Foundation
import DataStruct

struct CharacterContent: CollectionElement {
    var characterID: Int
    var id: Int?
    var title: String
    var description: String
    var thumbnailPath: String?
    var type: ContentType
    var thumbnailURL: URL? {
        guard let thumbnailPath else {
            return nil
        }
        return URL(string: thumbnailPath.replacingOccurrences(of: "http", with: "https"))
    }
}

extension CharacterContent {
    enum ContentType: Int, DatableValue, CaseIterable {
        case series, stories, comics, events
        var dataValue: Any {
            return rawValue
        }
    }
}

//MARK: - Datable
extension CharacterContent: Datable {
    static let modelData = ModelData<CharacterContent>()
    static var dataKeys = ["description": "contentDescription"]
    static func map(from object: ContentData?) -> CharacterContent? {
        guard let object, let type = ContentType(rawValue: Int(object.type)) else {
            return nil
        }
        return CharacterContent(characterID: Int(object.characterID), id: Int(object.oid), title: object.title ?? "", description: object.contentDescription ?? "", type: type)
    }
}
