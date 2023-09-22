//
//  AuthenticationParameters.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 22/09/2023.
//

import Foundation
import NetworkUI

struct AuthenticationParameters: Codable, Iterable {
    var ts: String
    var apiKey: String
    var hash: String
}
