//
//  RainbowAnimation.swift
//  SwiftUIDarkMode
//
//  Created by Jet Lye on 25/02/2023.
//

import SwiftUI

struct Rainbow: ViewModifier {
    let hueColors = stride(from: 0, to: 1, by: 0.01).map {
        Color(hue: $0, saturation: 1, brightness: 1)
    }

    func body(content: Content) -> some View {
        content
            .overlay(GeometryReader { (proxy: GeometryProxy) in
                ZStack {
                    LinearGradient(gradient: Gradient(colors: self.hueColors),
                                   startPoint: .leading,
                                   endPoint: .trailing)
                        .frame(width: proxy.size.width)
                }
            })
            .mask(content)
    }
}
