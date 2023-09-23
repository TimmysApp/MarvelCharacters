//
//  CharacterDTO.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 22/09/2023.
//

import Foundation

struct CharacterDTO: Codable {
    var id: Int
    @DefaultCodable var name: String
    @DefaultCodable var description: String
    var thumbnail: ThumbnailDTO?
    @DefaultCodable var resourceURI: String
    var comics: Contents?
    var series: Contents?
    var stories: Contents?
    var events: Contents?
    @DefaultCodable var urls: [URLItemDTO]
}
