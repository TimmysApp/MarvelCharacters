//
//  PhotoLoaderClientStub.swift
//  Marvel CharactersTests
//
//  Created by Joe Maghzal on 25/09/2023.
//

import Foundation
@testable import Marvel_Characters

struct PhotoLoaderClientStub: PhotoLoaderClient {
    let expectedData: Data
    let delay: UInt64?
    func load(for url: URL) async throws -> Data {
        if let delay {
            try? await Task.sleep(nanoseconds: delay)
        }
        return expectedData
    }
}
