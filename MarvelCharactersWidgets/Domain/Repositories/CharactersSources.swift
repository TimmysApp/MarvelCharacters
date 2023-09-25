//
//  CharactersSources.swift
//  MarvelCharactersWidgetsExtension
//
//  Created by Joe Maghzal on 25/09/2023.
//

import Foundation

protocol CharactersSource {
    func fetch() async throws -> [Character]
}
