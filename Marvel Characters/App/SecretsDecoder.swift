//
//  SecretsFactory.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 25/09/2023.
//

import Foundation

struct Secrets: Codable {
    var publicApiKey: String
    var privateApiKey: String
}

struct SecretsDecoder {
//MARK: - Proeprties
    private static var secrets: Secrets?
//MARK: - Functions
    static func read() -> Secrets {
        if let secrets = secrets {
            return secrets
        }
        let decodedSecrets = decode()
        secrets = decodedSecrets
        return decodedSecrets
    }
    private static func decode() -> Secrets {
        guard let secretsURL = Bundle.main.url(forResource: "Secrets", withExtension: "plist"), let data = try? Data(contentsOf: secretsURL) else {
            fatalError("Secrets.plist was not found")
        }
        let decoder = PropertyListDecoder()
        do {
            let secrets = try decoder.decode(Secrets.self, from: data)
            return secrets
        }catch {
            fatalError(error.localizedDescription)
        }
    }
}
