//
//  DefaultCodable.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 23/09/2023.
//

import Foundation

protocol DefaultProvidable: Codable {
    static var defaultValue: Self {get}
}

@propertyWrapper struct DefaultCodable<T: DefaultProvidable> {
    var wrappedValue: T
}

extension DefaultCodable: Codable {
    func encode(to encoder: Encoder) throws {
        try wrappedValue.encode(to: encoder)
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        wrappedValue = (try? container.decode(T.self)) ?? .defaultValue
    }
}

extension String: DefaultProvidable {
    static var defaultValue: Self {
        return ""
    }
}

extension Int: DefaultProvidable {
    static var defaultValue: Self {
        return 0
    }
}

extension Optional: DefaultProvidable where Wrapped: Codable {
    static var defaultValue: Self {
        return nil
    }
}

extension Array: DefaultProvidable where Element: Codable {
    static var defaultValue: Self {
        return []
    }
}
