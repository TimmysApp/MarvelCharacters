//
//  Contents.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 22/09/2023.
//

import Foundation

extension CharacterDTO {
    struct Contents: Codable {
        var available: Int
        var collectionURI: String
        var items: [Summary]
        var returned: Int
    }
}

extension CharacterDTO.Contents {
    struct Summary: Codable {
        var resourceURI: String
        var name: String
        var type: String
    }
}
