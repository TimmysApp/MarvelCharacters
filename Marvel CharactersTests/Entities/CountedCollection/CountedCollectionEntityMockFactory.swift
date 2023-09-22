//
//  CountedCollectionEntityMockFactory.swift
//  Marvel CharactersTests
//
//  Created by Joe Maghzal on 22/09/2023.
//

import Foundation
@testable import Marvel_Characters

struct CollectionElementStub: CollectionElement {
    var id = UUID()
}

struct CountedCollectionEntityMockFactory {
    static func assembleEmptyCollection() -> CountedCollection<CollectionElementStub> {
        return CountedCollection(count: 0, items: [])
    }
    static func assembleCollectionWithItems() -> CountedCollection<CollectionElementStub> {
        let items = [CollectionElementStub(), CollectionElementStub(), CollectionElementStub()]
        return CountedCollection(count: items.count, items: items)
    }
}
