//
//  RemotePhotoView.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 24/09/2023.
//

import SwiftUI

struct RemotePhotoView: View {
    @EnvironmentObject private var loader: PhotoLoader
    @State private var image: UIImage?
    @State private var loading = true
    let url: URL?
    var contentMode = ContentMode.fill
    var body: some View {
        if loading {
            ProgressView()
                .background(Material.ultraThin)
                .task {
                    guard let url else {
                        loading = false
                        return
                    }
                    let fetchedImage = await loader.loadImage(for: url)
                    image = fetchedImage
                    loading = false
                }
        }else {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
            }else {
                Color.gray
            }
        }
    }
}
