//
//  URLItemDTO.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 22/09/2023.
//

import Foundation

struct URLItemDTO: Codable {
    @DefaultCodable var type: String
    @DefaultCodable var url: String
}
