//
//  AdditionalLink.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 22/09/2023.
//

import Foundation
import DataStruct

struct AdditionalLink: CollectionElement {
    var id: UUID? = UUID()
    var type: String
    var path: String
    var url: URL? {
        return URL(string: path)
    }
}

//MARK: - Datable
extension AdditionalLink: Datable {
    static let modelData = ModelData<AdditionalLink>()
    static func map(from object: AdditionalLinkData?) -> AdditionalLink? {
        guard let object else {
            return nil
        }
        return AdditionalLink(id: object.oid, type: object.type ?? "", path: object.path ?? "")
    }
}
