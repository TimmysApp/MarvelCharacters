//
//  PaginatedResponse.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 22/09/2023.
//

import Foundation

struct PaginatedResponse<Element: Codable>: Codable {
    @DefaultCodable var offset: Int
    @DefaultCodable var limit: Int
    @DefaultCodable var total: Int
    @DefaultCodable var count: Int
    @DefaultCodable var results: [Element]
}
