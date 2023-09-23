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
            let thumbnailPath = item.thumbnail.path + "." + item.thumbnail.fileExtension
            return Character(id: item.id, name: item.name, description: item.description, modifiedDate: item.modified, thumbnailPath: thumbnailPath, comics: map(item.comics), series: map(item.series), stories: map(item.stories), events: map(item.events), additionalLinks: AdditionalLink.Mapper.map(item.urls))
        }
        static func map(_ items: [CharacterDTO]) -> [Character] {
            return items.map({map($0)})
        }
        static func map(_ content: CharacterDTO.Contents.Summary) -> Character.Content {
            return Character.Content(resourceURI: content.resourceURI, name: content.name, type: content.type)
        }
        static func map(_ content: CharacterDTO.Contents) -> [Character.Content] {
            return content.items.map({map($0)})
        }
    }
}
