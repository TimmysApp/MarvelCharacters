//
//  CharacterDetailsSource.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 24/09/2023.
//

import Foundation

protocol CharacterDetailsSource {
    func fetchComics(for characterID: Int) async throws -> [CharacterContent]
    func fetchSeries(for characterID: Int) async throws -> [CharacterContent]
    func fetchEvents(for characterID: Int) async throws -> [CharacterContent]
    func fetchStories(for characterID: Int) async throws -> [CharacterContent]
}
