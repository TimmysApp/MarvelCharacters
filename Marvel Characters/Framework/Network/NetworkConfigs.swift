//
//  NetworkConfigs.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 22/09/2023.
//

import Foundation
import NetworkUI

struct NetworkConfigs: NetworkConfigurations {
    static let client = Network(configurations: NetworkConfigs())
    var baseURL: URL? {
        return URL(string: "https://gateway.marvel.com/v1/public")
    }
}
