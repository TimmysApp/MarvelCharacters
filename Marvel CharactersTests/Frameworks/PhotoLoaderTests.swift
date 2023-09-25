//
//  PhotoLoaderTests.swift
//  Marvel CharactersTests
//
//  Created by Joe Maghzal on 25/09/2023.
//

import XCTest
import DataStruct
import CoreData
@testable import Marvel_Characters

final class PhotoLoaderTests: XCTestCase {
//MARK: - Properties
    private let stubURL = URL(string: "google.com")!
    private var objectContext: NSManagedObjectContext!
    private let expectedData = UIImage(named: "test")!.pngData()
//MARK: - Lifecycle
    override func setUp() async throws {
        try await super.setUp()
        objectContext = PersistenceControllerStub().container.newBackgroundContext()
    }
    override func tearDown() async throws {
        try await super.tearDown()
        objectContext = nil
    }
//MARK: - Functions
    private func loader(expectedData: Data?, delay: UInt64? = nil) -> PhotoLoader {
        return PhotoLoader(session: PhotoLoaderClientStub(expectedData: expectedData!, delay: delay), objectContext: objectContext)
    }
    private func saveStubCache(data: Data?) async {
        await withCheckedContinuation { continuation in
            objectContext.performAndWait {
                let photoCache = PhotoCache(url: stubURL.absoluteString, data: data)
                photoCache.save(objectContext)
                continuation.resume()
            }
        }
    }
//MARK: - Tests
    func testLoaderCachesDataWhenNotCached() async {
        let loader = loader(expectedData: expectedData)
        _ = await loader.loadImage(for: stubURL)
        let cachedData = try? PhotoCache.fetch(with: NSPredicate(format: "url == %@", stubURL.absoluteString), objectContext: objectContext).first?.data
        let lastCachedItem = await loader.lastSavedItem
        XCTAssertEqual(lastCachedItem, stubURL)
        XCTAssertEqual(cachedData, expectedData)
    }
    func testLoaderRemovesItemWhenDataIsEmpty() async {
        await saveStubCache(data: expectedData)
        let loader = loader(expectedData: expectedData)
        _ = await loader.loadImage(for: stubURL)
        let count = try? PhotoCache.fetch(with: NSPredicate(format: "url == %@", stubURL.absoluteString), objectContext: objectContext).count
        XCTAssertEqual(count, 1)
    }
    func testLoaderCachesDataWhenItemSavedWithoutData() async {
        await saveStubCache(data: nil)
        let loader = loader(expectedData: expectedData)
        _ = await loader.loadImage(for: stubURL)
        let lastCachedItem = await loader.lastSavedItem
        XCTAssertNotEqual(lastCachedItem, nil)
    }
    func testLoaderDoesNotCacheDataWhenCachedDataFound() async {
        await saveStubCache(data: expectedData)
        let loader = loader(expectedData: expectedData)
        _ = await loader.loadImage(for: stubURL)
        let lastCachedItem = await loader.lastSavedItem
        XCTAssertEqual(lastCachedItem, nil)
    }
    func testLoaderStoresTaskForURL() async {
        let loader = loader(expectedData: expectedData, delay: 100_000_000_000)
        Task {
            _ = await loader.loadImage(for: stubURL)
        }
        try? await Task.sleep(nanoseconds: 1_000_000)
        let runningTasks = await loader.runningTasks
        XCTAssertEqual(runningTasks, 1)
    }
    func testLoaderRemovesTaskWhenDone() async {
        let loader = loader(expectedData: expectedData)
        Task {
            _ = await loader.loadImage(for: stubURL)
        }
        try? await Task.sleep(nanoseconds: 1_000_000)
        let runningTasks = await loader.runningTasks
        XCTAssertEqual(runningTasks, 0)
    }
    func testLoaderDoesNotCreateMultipleTasksForSameURL() async {
        let expectedCalls = Int.random(in: 2..<10)
        let loader = loader(expectedData: expectedData, delay: 100_000_000_000)
        Task {
            for _ in 0..<expectedCalls {
                _ = await loader.loadImage(for: stubURL)
                _ = await loader.loadImage(for: stubURL)
            }
        }
        try? await Task.sleep(nanoseconds: 1_000_000)
        let runningTasks = await loader.runningTasks
        XCTAssertEqual(runningTasks, 1)
        XCTAssertNotEqual(runningTasks, expectedCalls)
    }
    func testLoaderSavesImageInNSCache() async {
        let loader = loader(expectedData: expectedData)
        let loadedImage = await loader.loadImage(for: stubURL)
        let cachedData = await loader.retreiveFromMemory(for: stubURL)
        XCTAssertEqual(cachedData, loadedImage)
    }
}
