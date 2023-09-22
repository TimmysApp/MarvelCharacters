//
//  CharacterDTO.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 22/09/2023.
//

import Foundation

struct CharacterDTO: Codable {
    var id: Int
    var name: String
    var description: String
    var modified: Date
    var thumbnail: ThumbnailDTO
    var resourceURI: String
    var comics: Contents
    var series: Contents
    var stories: Contents
    var events: Contents
    var urls: [URLItemDTO]
}
