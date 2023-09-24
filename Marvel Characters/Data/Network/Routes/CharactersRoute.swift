//
//  CharactersRoute.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 22/09/2023.
//

import Foundation
import NetworkUI

enum CharactersRoute: Route {
    case characters(parameters: CharactersParameters), details(characterID: Int, type: CharacterContent.ContentType)
    var route: URLRoute {
        let authenticationParameters = AuthenticationParametersFactory.assemble()
        return URLRoute(from: "characters")
            .appending {
                switch self {
                    case .details(let characterID, _):
                        return String(characterID)
                    default:
                        return nil
                }
            }.appending {
                switch self {
                    case .characters(let parameters):
                        return parameters
                    case .details(_, let type):
                        return CharacterDetailsRouteFactory.assemble(for: type)
                }
            }.appending(authenticationParameters)
    }
    var method: RequestMethod {
        return .GET
    }
}
