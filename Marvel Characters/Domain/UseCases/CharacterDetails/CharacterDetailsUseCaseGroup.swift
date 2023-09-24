//
//  CharacterDetailsUseCaseGroup.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 24/09/2023.
//

import Foundation

struct CharacterDetailsUseCaseGroup {
    let comicsUseCase: FetchCharacterComicsUseCase
    let eventsUseCase: FetchCharacterEventsUseCase
    let storiesUseCase: FetchCharacterStoriesUseCase
    let seriesUseCase: FetchCharacterSeriesUseCase
}
