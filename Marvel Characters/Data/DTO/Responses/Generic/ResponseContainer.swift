//
//  ResponseContainer.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 22/09/2023.
//

import Foundation

struct ResponseContainer<Element: Codable>: Codable {
    var code: Int
    var status: String
    var etag: String
    var data: Element
}
