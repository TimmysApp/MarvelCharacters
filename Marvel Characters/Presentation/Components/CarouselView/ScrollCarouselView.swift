//
//  ScrollCarouselView.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 23/09/2023.
//

import SwiftUI

public struct ScrollCarouselView<ID: Hashable & Identifiable, Content: View>: View {
//MARK: - Properties
    @State private var tapSelection: ID?
    @State private var appeared = false
    @Binding private var selection: ID?
    private let width: CGFloat
    private let data: [ID]
    private let spacing: CGFloat
    private let content: (ID) -> Content
    private let onSelection: ((ID) -> Void)?
    private let alignment: VerticalAlignment
    private let shouldSelect: ((ID) -> Bool)?
    private let selectionMap: ((ID) -> ID?)?
    private let scrollChange: ((Bool) -> Void)?
//MARK: - Initializers
    public init(_ data: [ID], selection: Binding<ID?>, width: CGFloat, alignment: VerticalAlignment = .center, spacing: CGFloat, @ViewBuilder content: @escaping (ID) -> Content) {
        self.data = data
        self._selection = selection
        self.width = width
        self.spacing = spacing
        self.content = content
        self.onSelection = nil
        self.alignment = alignment
        self.shouldSelect = nil
        self.selectionMap = nil
        self.scrollChange = nil
    }
    private init(_ data: [ID], selection: Binding<ID?>, width: CGFloat, alignment: VerticalAlignment, spacing: CGFloat, @ViewBuilder content: @escaping (ID) -> Content, onSelection: ((ID) -> Void)?, shouldSelect: ((ID) -> Bool)?, selectionMap: ((ID) -> ID?)?, scrollChange: ((Bool) -> Void)?) {
        self.data = data
        self._selection = selection
        self.width = width
        self.spacing = spacing
        self.content = content
        self.onSelection = onSelection
        self.alignment = alignment
        self.shouldSelect = shouldSelect
        self.selectionMap = selectionMap
        self.scrollChange = scrollChange
    }
//MARK: - Body
    public var body: some View {
        GeometryReader { reader in
            let padding = abs(reader.frame(in: .global).width - (spacing + width))
            ScrollViewReader { scrollReader in
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(alignment: alignment, spacing: 0) {
                        ForEach(data) { item in
                            HStack(spacing: 0) {
                                Color.clear
                                    .frame(width: spacing)
                                content(item)
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        onSelection?(item)
                                        tapSelection = item
                                        select(item, reader: scrollReader)
                                    }
                            }.id(item)
                        }
                        Color.clear
                            .frame(width: padding)
                    }.onScroll(.horizontal) { newValue in
                        guard appeared else {
                            select(selection, reader: scrollReader)
                            appeared = true
                            return
                        }
                        let factor = width + spacing
                        var approximateIndex = Int(round(newValue/factor))
                        if approximateIndex > (data.count - 1) {
                            approximateIndex = data.count - 1
                        }
                        if approximateIndex < 0 {
                            approximateIndex = 0
                        }
                        if Int(round(newValue)) % Int(factor) == 0 && selection != data[approximateIndex] {
                            let generator = UISelectionFeedbackGenerator()
                            generator.selectionChanged()
                        }
                        let newSelection = data[approximateIndex]
                        if tapSelection == newSelection || tapSelection == nil {
                            selection = newSelection
                            tapSelection = nil
                        }
                    }.onScrollEnd { _ in
                        select(selection, reader: scrollReader)
                    }
                }.coordinateSpace(name: "scroll")
            }
        }
    }
//MARK: - Functions
    private func select(_ item: ID?, reader: ScrollViewProxy) {
        guard let selectionItem = item ?? data.first, shouldSelect?(selectionItem) ?? true else {return}
        selection = selectionMap?(selectionItem) ?? item
        withAnimation(.easeIn) {
            reader.scrollTo(selection, anchor: .leading)
        }
    }
//MARK: - Modifiers
    public func onTap(_ action: @escaping (ID) -> Void) -> Self {
        return ScrollCarouselView(data, selection: $selection, width: width, alignment: alignment, spacing: spacing, content: content, onSelection: action, shouldSelect: shouldSelect, selectionMap: selectionMap, scrollChange: scrollChange)
    }
    public func shouldSelect(_ action: @escaping (ID) -> Bool) -> Self {
        return ScrollCarouselView(data, selection: $selection, width: width, alignment: alignment, spacing: spacing, content: content, onSelection: onSelection, shouldSelect: action, selectionMap: selectionMap, scrollChange: scrollChange)
    }
    public func mapSelection(_ action: @escaping (ID) -> ID?) -> Self {
        return ScrollCarouselView(data, selection: $selection, width: width, alignment: alignment, spacing: spacing, content: content, onSelection: onSelection, shouldSelect: shouldSelect, selectionMap: action, scrollChange: scrollChange)
    }
    public func onScrollChange(_ action: @escaping (Bool) -> Void) -> Self {
        return ScrollCarouselView(data, selection: $selection, width: width, alignment: alignment, spacing: spacing, content: content, onSelection: onSelection, shouldSelect: shouldSelect, selectionMap: selectionMap, scrollChange: action)
    }
}

struct ScrollCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselTestView()
    }
}

fileprivate struct CarouselTestView: View {
    @State var data = MockDataModel.mock
    @State var selected: MockDataModel?
    var body: some View {
        ScrollCarouselView(data, selection: $selected, width: 50, spacing: 10) { item in
            Circle()
                .foregroundColor(item == selected ? .red: .blue)
                .frame(width: 50, height: 50)
        }
    }
}

fileprivate struct MockDataModel: Hashable, Identifiable {
    var id: Int {
        return item
    }
    var item: Int
    static var mock: [MockDataModel] {
        (0..<20).reduce(into: [MockDataModel]()) { partialResult, item in
            partialResult.append(MockDataModel(item: item))
        }
    }
}
