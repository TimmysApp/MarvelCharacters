//
//  HomeViewFactory.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 24/09/2023.
//

import SwiftUI
import NetworkUI

struct HomeViewFactory {
    @MainActor static func assemble() -> some View {
        let photoLoader = PhotoLoader(session: .shared, objectContext: PersistenceController.shared.container.newBackgroundContext())
        let remoteSource = CharactersService(network: Network(configurations: NetworkConfigs()))
        let localSource = CharactersDatabase(objectContext: PersistenceController.shared.container.newBackgroundContext())
        let remoteSourceGateway = CharactersRemoteSourceGateway(remoteSource: remoteSource, localSource: localSource)
        let repository = CharactersRepository(remoteSource: remoteSourceGateway, localSource: localSource)
        let useCase = FetchCharactersUseCase(source: repository)
        let viewModel = HomeViewModel(useCase: useCase, loader: photoLoader)
        return HomeView(viewModel: viewModel)
            .environmentObject(photoLoader)
    }
}
