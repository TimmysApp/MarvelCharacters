//
//  CharacterDetailsRepository.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 24/09/2023.
//

import Foundation

struct CharacterDetailsRepository {
    let useCase: CharacterDetailsContentUseCase
}

//MARK: - CharacterDetailsSource
extension CharacterDetailsRepository: CharacterDetailsSource {
    func fetchContent(for characterID: Int) async throws -> [FeaturedContent] {
        try await withThrowingTaskGroup(of: (CharacterContent.ContentType, [CharacterContent]).self) { group in
            let types = CharacterContent.ContentType.allCases
            types.forEach { type in
                group.addTask {
                    return (type, try await useCase.fetch(for: characterID, type: type))
                }
            }
            let sectionsDictionary = try await group.reduce(into: [:]) { partialResult, item in
                partialResult[item.0] = item.1
            }
            return types.compactMap { type -> FeaturedContent? in
                let content = sectionsDictionary[type] ?? []
                if content.isEmpty {
                    return nil
                }
                return FeaturedContent(type: type, content: content)
            }
        }
    }
}
