//
//  CountedCollection.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 22/09/2023.
//

import Foundation

typealias CollectionElement = Identifiable & Equatable & Hashable

struct CountedCollection<Element: CollectionElement>: Equatable, Hashable {
    var count: Int
    var items: [Element]
}
