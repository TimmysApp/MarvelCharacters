//
//  FeaturedContentEntityMockFactory.swift
//  Marvel CharactersTests
//
//  Created by Joe Maghzal on 25/09/2023.
//

import Foundation
@testable import Marvel_Characters

struct FeaturedContentEntityMockFactory {
    static func assembleContent(type: CharacterContent.ContentType, characterID: Int) -> FeaturedContent {
        let content = CharacterContentEntityMockFactory.assembleCharacters(offset: 0, limit: 10, type: type, characterID: characterID)
        return FeaturedContent(type: type, content: content)
    }
    static func assembleContent(characterID: Int) -> [FeaturedContent] {
        return CharacterContent.ContentType.allCases.map({assembleContent(type: $0, characterID: characterID)})
    }
}
