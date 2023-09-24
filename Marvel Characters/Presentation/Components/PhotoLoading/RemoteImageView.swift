//
//  RemoteImageView.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 24/09/2023.
//

import UIKit

class RemoteImageView: UIImageView {
//MARK: - Properties
    var loader: PhotoLoader?
    var url: URL? {
        didSet {
            Task {
                await loadImage()
            }
        }
    }
//MARK: - Functions
    private func loadImage() async {
        guard let url else {
            return
        }
        let fetchedImage = await loader?.loadImage(for: url)
        image = fetchedImage
    }
}
