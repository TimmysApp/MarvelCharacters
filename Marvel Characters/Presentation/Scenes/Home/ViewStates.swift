//
//  ViewStates.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 24/09/2023.
//

import Foundation

enum ContentViewState: Equatable {
    case empty, error(String), loading, loaded
    var loaded: Bool {
        switch self {
            case .loaded:
                return true
            default:
                return false
        }
    }
}

enum HomeDisplayStyle {
    case list, carousel
}

enum CharacterDisplayStyle: Identifiable, Hashable {
    case info(Character), pagination
    func get() -> Character? {
        switch self {
            case .info(let character):
                return character
            case .pagination:
                return nil
        }
    }
    var id: Int {
        return get()?.id ?? -10
    }
}

