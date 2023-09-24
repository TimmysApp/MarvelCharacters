//
//  CharacterTableCellViewModel.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 23/09/2023.
//

import Foundation

struct CharacterTableCellViewModel {
    var imageURL: URL?
    var title: String
    var description: String
    var loader: PhotoLoader?
}

protocol CharacterTableViewCellDelegate: AnyObject {
    func didSelect(at indexPath: IndexPath)
}
