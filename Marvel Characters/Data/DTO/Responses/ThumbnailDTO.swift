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
}
