//
//  CharactersRoute.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 22/09/2023.
//

import Foundation
import NetworkUI

enum CharactersRoute: Route {
    case characters(parameters: CharactersParameters), comics(characterID: Int), events(characterID: Int), stories(characterID: Int), series(characterID: Int)
    var route: URLRoute {
        let authenticationParameters = AuthenticationParametersFactory.assemble()
        return URLRoute(from: "characters")
            .appending {
                switch self {
                    case .comics(let characterID), .events(let characterID), .stories(let characterID), .series(let characterID):
                        return String(characterID)
                    default:
                        return nil
                }
            }.appending {
                switch self {
                    case .characters(let parameters):
                        return parameters
                    case .comics:
                        return "comics"
                    case .events:
                        return "events"
                    case .stories:
                        return "stories"
                    case .series:
                        return "series"
                }
            }.appending(authenticationParameters)
    }
    var method: RequestMethod {
        return .GET
    }
}
