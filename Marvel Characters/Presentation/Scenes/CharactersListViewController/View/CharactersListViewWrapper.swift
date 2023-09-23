//
//  CharactersListViewWrapper.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 23/09/2023.
//

import SwiftUI
import NetworkUI

struct CharactersListViewWrapper: UIViewControllerRepresentable {
    let viewModel: CharactersListViewModel
    func makeUIViewController(context: Context) -> CharactersListViewController {
        let viewController = CharactersListViewController(viewModel: viewModel)
        return viewController
    }
    func updateUIViewController(_ uiViewController: CharactersListViewController, context: Context) {
    }
}

struct CharactersListViewFactory {
    @MainActor static func assemble() -> some View {
        let remoteSource = CharactersService(network: Network(configurations: NetworkConfigs()))
        let localSource = CharactersDatabase(objectContext: PersistenceController.shared.container.newBackgroundContext())
        let remoteSourceGateway = CharactersRemoteSourceGateway(remoteSource: remoteSource, localSource: localSource)
        let repository = CharactersRepository(remoteSource: remoteSourceGateway, localSource: localSource)
        let useCase = FetchCharactersUseCase(source: repository)
        let viewModel = CharactersListViewModel(useCase: useCase)
        return CharactersListViewWrapper(viewModel: viewModel)
            .edgesIgnoringSafeArea(.all)
    }
}
