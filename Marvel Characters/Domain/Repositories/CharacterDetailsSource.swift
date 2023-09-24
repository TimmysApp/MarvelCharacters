//
//  CharacterDetailsSource.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 24/09/2023.
//

import Foundation

protocol CharacterDetailsSource {
    func fetchContent(for characterID: Int) async throws -> [FeaturedContent]
}
