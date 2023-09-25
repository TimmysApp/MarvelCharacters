//
//  CharacterDetailsRouteFactory.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 24/09/2023.
//

import Foundation
import NetworkUI

struct CharacterDetailsRouteFactory {
    static func assemble(for type: CharacterContent.ContentType) -> String {
        switch type {
            case .series:
                return "series"
            case .stories:
                return "stories"
            case .comics:
                return "comics"
            case .events:
                return "events"
        }
    }
}
