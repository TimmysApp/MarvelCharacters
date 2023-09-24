//
//  CharactersListViewWrapper.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 23/09/2023.
//

import SwiftUI
import NetworkUI

struct CharactersListViewWrapper: UIViewControllerRepresentable {
    let viewModel: HomeViewModel
    func makeUIViewController(context: Context) -> CharactersListViewController {
        let viewController = CharactersListViewController(viewModel: viewModel)
        return viewController
    }
    func updateUIViewController(_ uiViewController: CharactersListViewController, context: Context) {
    }
}
