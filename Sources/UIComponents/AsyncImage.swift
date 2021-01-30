//
//  AsyncImage.swift
//  SwiftUINavigation
//
//  Created by Анна  Зелинская on 09.01.2021.
//

import Foundation
import SwiftUI

public struct AsyncImage<Placeholder: View>: View {
    
    @StateObject private var loader: ImageLoader
    private let placeholder: Placeholder
    private let image: (UIImage) -> Image
    
    public init(
        url: URL,
        @ViewBuilder placeholder: () -> Placeholder,
        @ViewBuilder image: @escaping (UIImage) -> Image = Image.init(uiImage:)
    ) {
        self.placeholder = placeholder()
        self.image = image
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
    }
    
    public var body: some View {
        content
            .onAppear(perform: loader.load)
    }
    
    private var content: some View {
        ZStack {
            if let img = loader.image {
                image(img)
            } else {
                placeholder
            }
        }
    }
}
