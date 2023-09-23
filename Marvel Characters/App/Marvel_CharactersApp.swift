//
//  Marvel_CharactersApp.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 22/09/2023.
//

import SwiftUI

@main
struct Marvel_CharactersApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            CharactersListViewFactory.assemble()
        }
    }
}
