//
//  CharacterMapper.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 23/09/2023.
//

import Foundation

extension Character {
    struct Mapper {
        static func map(_ item: CharacterDTO) -> Character {
            var thumbnailPath: String?
            if let thumbnail = item.thumbnail {
                thumbnailPath = thumbnail.path + "." + thumbnail.fileExtension
            }
            return Character(id: item.id, name: item.name, description: item.description, thumbnailPath: thumbnailPath, additionalLinks: AdditionalLink.Mapper.map(item.urls))
        }
        static func map(_ items: [CharacterDTO]) -> [Character] {
            return items.map({map($0)})
        }
    }
}
