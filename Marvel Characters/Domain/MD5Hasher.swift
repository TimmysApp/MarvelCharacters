//
//  MD5Hasher.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 22/09/2023.
//

import Foundation
import CryptoKit

struct MD5Hasher {
    static func hash(_ string: String) -> String {
        let digest = Insecure.MD5.hash(data: Data(string.utf8))
        return digest.map({String(format: "%02hhx", $0)}).joined()
    }
}
