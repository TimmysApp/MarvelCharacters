//
//  CharactresWidgetTimelineProviderFactory.swift
//  MarvelCharactersWidgetsExtension
//
//  Created by Joe Maghzal on 25/09/2023.
//

import WidgetKit

struct CharactresWidgetTimelineProviderFactory {
    static func assemble() ->  CharactersTimelineProvider {
        let objectContext = PersistenceController.shared.mainBackgroundContext()
        let source = CharactersDatabase(objectContext: objectContext)
        let repository = CharactersRepository(localSource: source)
        let useCase = FetchCharactersUseCase(source: repository)
        let provider = CharactersTimelineProvider(objectContext: objectContext, useCase: useCase)
        return provider
    }
}
