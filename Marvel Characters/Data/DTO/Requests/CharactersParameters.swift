//
//  CharactersParameters.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 22/09/2023.
//

import Foundation
import NetworkUI

struct CharactersParameters: Codable, Iterable {
    var name: String?
    var searchName: String?
    var limit: Int
    var offset: Int
}
