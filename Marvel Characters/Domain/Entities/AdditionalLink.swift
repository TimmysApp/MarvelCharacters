//
//  AdditionalLink.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 22/09/2023.
//

import Foundation

struct AdditionalLink: CollectionElement {
    var id = UUID()
    var type: String
    var path: String
    var url: URL? {
        return URL(string: path)
    }
}
