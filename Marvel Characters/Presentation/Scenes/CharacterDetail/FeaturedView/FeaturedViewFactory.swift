//
//  FeaturedViewFactory.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 24/09/2023.
//

import SwiftUI
import NetworkUI

struct FeaturedViewFactory {
    @MainActor static func assemble(for characterID: Int) -> some View {
        let detailsContentLocalSource = CharacterDetailsDatabase(objectContext: PersistenceController.shared.mainBackgroundContext())
        let detailsContentRemoteSource = CharacterDetailsService(network: Network(configurations: NetworkConfigs()))
        let detailsContentRemoteSourceGateway = CharacterDetailsRemoteSourceGateway(remoteSource: detailsContentRemoteSource, localSource: detailsContentLocalSource)
        let detailsContentRepository = CharacterDetailsContentRepository(remoteSource: detailsContentRemoteSourceGateway, localSource: detailsContentLocalSource)
        let detailsContentUseCase = CharacterDetailsContentUseCase(source: detailsContentRepository)
        let detailsRepository = CharacterDetailsRepository(useCase: detailsContentUseCase)
        let detailsUseCase = CharacterDetailsUseCase(source: detailsRepository)
        let viewModel = FeaturedViewModel(characterID: characterID, useCase: detailsUseCase)
        return FeaturedView(viewModel: viewModel)
    }
}
