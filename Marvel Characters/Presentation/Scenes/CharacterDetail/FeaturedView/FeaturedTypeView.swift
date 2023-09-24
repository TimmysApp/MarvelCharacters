//
//  FeaturedTypeView.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 24/09/2023.
//

import SwiftUI

struct FeaturedTypeView: View {
    @Environment(\.screenSize) private var screenSize
    let content: FeaturedContent
    private let spacing: CGFloat = 15
    private var width: CGFloat {
        return (screenSize.width - 4 * 15)/3
    }
    var body: some View {
        VStack(alignment: .leading) {
            Text(content.type.title)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(Color.text)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack(alignment: .top, spacing: spacing) {
                ForEach(content.content) { item in
                    VStack {
                        RemotePhotoView(url: item.thumbnailURL)
                            .frame(width: width, height: width * 1.5)
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        Text(item.title)
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundStyle(Color.text)
                            .multilineTextAlignment(.center)
                    }.frame(width: width)
                }
            }
        }
    }
}
