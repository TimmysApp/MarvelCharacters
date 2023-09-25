//
//  PhotoLoader.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 24/09/2023.
//

import SwiftUI
import CoreData
import DataStruct

actor PhotoLoader: ObservableObject {
//MARK: - Properties
    private var inMememoryPhotos: [URL: UIImage?] = [:]
    private let objectContext: NSManagedObjectContext
    private let session: URLSession
    private var tasks: [URL: Task<UIImage?, Error>] = [:]
//MARK: - Initializer
    init(session: PhotoLoaderClient, objectContext: NSManagedObjectContext, cahingLimit: Int = 100) {
        self.session = session
        self.objectContext = objectContext
        self.cacheStore.countLimit = cahingLimit
    }
//MARK: - Functions
    func loadImage(for url: URL) async -> UIImage? {
        if let memoryImage = inMememoryPhotos[url] {
            return memoryImage
        }
        return await fetchImage(for: url)
    }
    private func fetchImage(for url: URL) async -> UIImage? {
        if let cachedImage = checkCache(for: url) {
            storeInMemory(cachedImage, for: url)
            return cachedImage
        }
        guard let task = tasks[url] else {
            let task = Task {
                let data = try await session.data(from: url).0
                cache(data: data, for: url)
                let image = UIImage(data: data)
                storeInMemory(image, for: url)
                return image
            }
            tasks[url] = task
            return try? await task.value
        }
        return try? await task.value
    }
    private func cache(data: Data?, for url: URL) {
        let photoCache = PhotoCache(url: url.absoluteString, data: data)
        photoCache.save(objectContext)
    }
    private func checkCache(for url: URL) -> UIImage? {
        guard let data = try? PhotoCache.fetch(with: NSPredicate(format: "url == %@", url.absoluteString), objectContext: objectContext).first?.data else {
            return nil
        }
        return UIImage(data: data)
    }
    private func removeFromMemory(url: URL) {
        inMememoryPhotos.removeValue(forKey: url)
    }
    private func storeInMemory(_ image: UIImage?, for url: URL) {
        inMememoryPhotos[url] = image
    }
}
