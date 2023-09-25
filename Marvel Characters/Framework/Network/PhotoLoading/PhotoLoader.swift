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
    private let objectContext: NSManagedObjectContext
    private let session: PhotoLoaderClient
    private var tasks: [URL: Task<UIImage?, Never>] = [:]
    var cacheStore = NSCache<NSURL, UIImage>()
    var runningTasks: Int {
        return tasks.count
    }
    var lastSavedItem: URL?
//MARK: - Initializer
    init(session: PhotoLoaderClient, objectContext: NSManagedObjectContext, cahingLimit: Int = 100) {
        self.session = session
        self.objectContext = objectContext
        self.cacheStore.countLimit = cahingLimit
    }
//MARK: - Public Functions
    func loadImage(for url: URL) async -> UIImage? {
        if let memoryImage = retreiveFromMemory(for: url) {
            return memoryImage
        }
        return await fetchImage(for: url)
    }
    func removeFromMemory(url: URL) {
        cacheStore.removeObject(forKey: url as NSURL)
    }
    func storeInMemory(_ image: UIImage?, for url: URL) {
        guard let image else {return}
        cacheStore.setObject(image, forKey: url as NSURL)
    }
    func retreiveFromMemory(for url: URL) -> UIImage? {
        return cacheStore.object(forKey: url as NSURL)
    }
    func fetchData(for url: URL) async -> Data? {
        let task = Task {
            let data = try? await session.load(for: url)
            return data
        }
        return await task.value
    }
//MARK: - Private Functions
    private func fetchImage(for url: URL) async -> UIImage? {
        if let cachedImage = await checkCache(for: url) {
            storeInMemory(cachedImage, for: url)
            return cachedImage
        }
        guard let task = tasks[url] else {
            let task = Task {
                let data = try? await session.load(for: url)
                let image = UIImage(data: data ?? Data())
                if let image {
                    await cache(data: data, for: url)
                    storeInMemory(image, for: url)
                }
                tasks.removeValue(forKey: url)
                return image
            }
            tasks[url] = task
            return await task.value
        }
        return await task.value
    }
    private func cache(data: Data?, for url: URL) async {
        await withCheckedContinuation { continuation in
            objectContext.performAndWait {
                let photoCache = PhotoCache(url: url.absoluteString, data: data)
                lastSavedItem = url
                photoCache.save(objectContext)
                continuation.resume()
            }
        }
    }
    private func checkCache(for url: URL) async -> UIImage? {
        await withCheckedContinuation { continuation in
            if let item = try? PhotoCache.fetch(with: NSPredicate(format: "url == %@", url.absoluteString), objectContext: objectContext).first {
                if let data = item.data {
                    continuation.resume(returning: UIImage(data: data))
                }else {
                    objectContext.performAndWait {
                        item.delete(objectContext)
                        continuation.resume(returning: nil)
                    }
                }
            }else {
                continuation.resume(returning: nil)
            }
        }
    }
}
