//
//  CharacterContentMapper.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 24/09/2023.
//

import Foundation

extension CharacterContent {
    struct Mapper {
        static func map(_ item: ContentDTO, characterID: Int, type: CharacterContent.ContentType) -> CharacterContent {
            var thumbnailPath: String?
            if let thumbnail = item.thumbnail {
                thumbnailPath = thumbnail.path + "." + thumbnail.fileExtension
            }
            return CharacterContent(characterID: characterID, id: item.id, title: item.title, description: item.description, thumbnailPath: thumbnailPath, type: type)
        }
        static func map(_ items: [ContentDTO], characterID: Int, type: CharacterContent.ContentType) -> [CharacterContent] {
            return items.map({map($0, characterID: characterID, type: type)})
        }
    }
}
