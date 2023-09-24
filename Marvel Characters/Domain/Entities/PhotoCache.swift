//
//  PhotoCache.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 24/09/2023.
//

import Foundation
import DataStruct

struct PhotoCache {
    var id: UUID? = UUID()
    var url: String
    var data: Data?
    static let modelData = ModelData<PhotoCache>()
}

//MARK: - Datable
extension PhotoCache: Datable {
    static func map(from object: PhotoData?) -> PhotoCache? {
        guard let object else {
            return nil
        }
        return PhotoCache(id: object.oid, url: object.url ?? "", data: object.data)
    }
}
