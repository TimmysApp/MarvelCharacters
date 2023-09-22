//
//  Character.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 22/09/2023.
//

import Foundation

struct Character: CollectionElement {
    var id: Int
    var name: String
    var description: String
    var modifiedDate: Date
    var thumbnailPath: String
    var comics: CountedCollection<Content>
    var series: CountedCollection<Content>
    var stories: CountedCollection<Content>
    var events: CountedCollection<Content>
    var thumbnailURL: URL? {
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
