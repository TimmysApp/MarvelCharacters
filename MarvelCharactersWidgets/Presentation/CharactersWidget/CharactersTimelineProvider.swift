//
//  MarvelCharactersWidgets.swift
//  MarvelCharactersWidgets
//
//  Created by Joe Maghzal on 25/09/2023.
//

import WidgetKit
import DataStruct
import CoreData

struct CharactersTimelineProvider {
//MARK: - Propeties
    let objectContext: NSManagedObjectContext
    let useCase: FetchCharactersUseCase
//MARK: - Functions
    private func getEntries() async -> [CharacterEntity] {
        do {
            let currentDate = Date()
            let characters = try await useCase.fetch()
            let entries = characters.indices.map { index in
                let character = characters[index]
                var photoData: Data?
                if let url = character.thumbnailURL?.absoluteString {
                    photoData = try? PhotoCache.fetch(with: NSPredicate(format: "url == %@", url), objectContext: objectContext).first?.data
                }
                let newDate = Calendar.current.date(byAdding: .hour, value: index, to: currentDate)!
                return CharacterEntity(date: newDate, character: character, photoData: photoData, preview: false, empty: false)
            }
            return entries
        }catch {
            return []
        }
    }
    private func checkEmpty(entries: [CharacterEntity]) -> [CharacterEntity] {
        guard entries.isEmpty else {
            return entries
        }
        return [CharacterEntity(date: Date(), character: .preview, photoData: nil, preview: false, empty: true)]
    }
}

//MARK: - TimelineProvider
extension CharactersTimelineProvider: TimelineProvider {
    func placeholder(in context: Context) -> CharacterEntity {
        return CharacterEntity(date: Date(), character: .preview, photoData: nil, preview: true, empty: false)
    }
    func getSnapshot(in context: Context, completion: @escaping (CharacterEntity) -> Void) {
        let entry = CharacterEntity(date: Date(), character: .preview, photoData: nil, preview: true, empty: false)
        completion(entry)
    }
    func getTimeline(in context: Context, completion: @escaping (Timeline<CharacterEntity>) -> Void) {
        Task {
            let entries = await checkEmpty(entries: getEntries())
            let timeline = Timeline(entries: entries, policy: .atEnd)
            completion(timeline)
        }
    }
}
