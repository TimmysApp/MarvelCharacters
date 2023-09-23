//
//  Character.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 22/09/2023.
//

import Foundation

typealias CollectionElement = Identifiable & Equatable & Hashable

struct Character: CollectionElement {
    var id: Int
    var name: String
    var description: String
    var thumbnailPath: String?
    var comics: [Content]
    var series: [Content]
    var stories: [Content]
    var events: [Content]
    var thumbnailURL: URL? {
        guard let thumbnailPath else {
            return nil
        }
        return URL(string: thumbnailPath)
    }
    var additionalLinks: [AdditionalLink]
}

extension Character {
    struct Content: CollectionElement {
        var id = UUID()
        var resourceURI: String
        var name: String
        var type: String?
        var isStory: Bool {
            return type != nil
        }
    }
}
