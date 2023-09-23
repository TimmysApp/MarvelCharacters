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
        let repository = CharactersRepository(remoteSource: remoteSource, localSource: LocalSourceMock())
        let useCase = FetchCharactersUseCase(source: repository)
        let viewModel = CharactersListViewModel(useCase: useCase)
        return CharactersListViewWrapper(viewModel: viewModel)
            .edgesIgnoringSafeArea(.all)
    }
}

struct LocalSourceMock: CharactersLocalSource {
    func fetch(using parameters: CharactersParameters) async throws -> [Character] {
        return []
    }
}
