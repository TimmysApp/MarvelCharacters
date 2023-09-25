//
//  ThumbnailDTO.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 22/09/2023.
//

import Foundation

struct ThumbnailDTO: Codable {
    @DefaultCodable var path: String
    @DefaultCodable var fileExtension: String
    enum CodingKeys: String, CodingKey {
        case path
        case fileExtension = "extension"
    }
}
