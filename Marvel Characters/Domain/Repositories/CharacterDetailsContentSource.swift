//
//  CharacterDetailsContentSource.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 24/09/2023.
//

import Foundation

protocol CharacterDetailsContentSource {
    func fetchContent(for characterID: Int, type: CharacterContent.ContentType) async throws -> [CharacterContent]
}
