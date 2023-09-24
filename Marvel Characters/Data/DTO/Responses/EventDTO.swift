//
//  EventDTO.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 24/09/2023.
//

import Foundation

struct EventDTO: Codable {
    @DefaultCodable var id: Int
    @DefaultCodable var title: String
    @DefaultCodable var description: String
    var thumbnail: ThumbnailDTO?
}
