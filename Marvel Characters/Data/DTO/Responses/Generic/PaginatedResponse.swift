//
//  PaginatedResponse.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 22/09/2023.
//

import Foundation

struct PaginatedResponse<Element: Codable>: Codable {
    var offset: Int
    var limit: Int
    var total: Int
    var count: Int
    var results: [Element]
}
