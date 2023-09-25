//
//  AuthenticationParametersFactory.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 22/09/2023.
//

import Foundation
import NetworkUI

struct AuthenticationParametersFactory {
    static func assemble() -> some Iterable {
        let timestamp = String(Date().timeIntervalSince1970)
        let secrets = SecretsDecoder.read()
        let hashRawString = timestamp + secrets.privateApiKey + secrets.publicApiKey
        return AuthenticationParameters(ts: timestamp, apikey: secrets.publicApiKey, hash: MD5Hasher.hash(hashRawString))
    }
}
