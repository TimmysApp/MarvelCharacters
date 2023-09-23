//
//  AdditionalLinkMapper.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 23/09/2023.
//

import Foundation

extension AdditionalLink {
    struct Mapper {
        static func map(_ item: URLItemDTO) -> AdditionalLink {
            return AdditionalLink(type: item.type, path: item.url)
        }
        static func map(_ items: [URLItemDTO]) -> [AdditionalLink] {
            return items.map({map($0)})
        }
    }
}
