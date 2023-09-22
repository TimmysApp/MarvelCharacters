//
//  CharactersLocalSource.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 23/09/2023.
//

import Foundation

protocol CharactersLocalSource {
    func fetch(using parameters: CharactersParameters) async throws -> [Character]
}
