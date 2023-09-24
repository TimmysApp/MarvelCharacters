//
//  FeaturedContent.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 24/09/2023.
//

import Foundation

struct FeaturedContent: Identifiable {
    var id = UUID()
    var type: CharacterContent.ContentType
    var content: [CharacterContent]
}
