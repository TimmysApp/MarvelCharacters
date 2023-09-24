//
//  RemoteImageView.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 24/09/2023.
//

import SwiftUI

class RemoteImageView: UIView {
//MARK: - Properties
    var url: URL? {
        didSet {
            loadImage()
        }
    }
//MARK: - Functions
    private func loadImage() {
        let hostingController = UIHostingController(rootView: RemotePhotoView(url: url))
        guard let hostingView = hostingController.view else {return}
        hostingView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(hostingView)
        setUpConstraints(hostingView)
    }
    private func setUpConstraints(_ hostingView: UIView) {
        NSLayoutConstraint.activate([
            hostingView.topAnchor.constraint(equalTo: topAnchor),
            hostingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            hostingView.centerXAnchor.constraint(equalTo: centerXAnchor),
            hostingView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
