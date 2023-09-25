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
        let objectContext = PersistenceController.shared.mainBackgroundContext()
        let photoLoader = PhotoLoader(session: URLSession.shared, objectContext: objectContext)
        let remoteSource = CharactersService(network: NetworkConfigs.client)
        let localSource = CharactersDatabase(objectContext: objectContext)
        let remoteSourceGateway = CharactersRemoteSourceGateway(remoteSource: remoteSource, localSource: localSource)
        let repository = CharactersRepository(remoteSource: remoteSourceGateway, localSource: localSource)
        let useCase = FetchCharactersUseCase(source: repository)
        let viewModel = HomeViewModel(useCase: useCase)
        return HomeView(viewModel: viewModel)
            .environmentObject(photoLoader)
    }
}
