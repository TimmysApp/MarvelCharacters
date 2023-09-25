//
//  PhotoLoaderClient.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 25/09/2023.
//

import Foundation

protocol PhotoLoaderClient {
    func load(for url: URL) async throws -> Data
}

extension URLSession: PhotoLoaderClient {
    func load(for url: URL) async throws -> Data {
        return try await data(from: url).0
    }
}
