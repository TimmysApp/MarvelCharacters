//
//  CharactersRoute.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 22/09/2023.
//

import Foundation
import NetworkUI

enum CharactersRoute: Route {
    case characters(parameters: CharactersParameters)
    var route: URLRoute {
        let authenticationParameters = AuthenticationParametersFactory.assemble()
        return URLRoute(from: "characters")
            .appending(authenticationParameters)
            .appending {
                switch self {
                    case .characters(let parameters):
                        return parameters
                }
            }
    }
    var method: RequestMethod {
        switch self {
            case .characters:
                return .GET
        }
    }
}
