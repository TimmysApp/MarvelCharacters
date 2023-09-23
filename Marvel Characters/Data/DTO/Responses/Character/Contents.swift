//
//  Contents.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 22/09/2023.
//

import Foundation

extension CharacterDTO {
    struct Contents: Codable {
        @DefaultCodable var available: Int
        @DefaultCodable var collectionURI: String
        @DefaultCodable var items: [Summary]
        @DefaultCodable var returned: Int
    }
}

extension CharacterDTO.Contents {
    struct Summary: Codable {
        @DefaultCodable var resourceURI: String
        @DefaultCodable var name: String
        @DefaultCodable var type: String?
    }
}
