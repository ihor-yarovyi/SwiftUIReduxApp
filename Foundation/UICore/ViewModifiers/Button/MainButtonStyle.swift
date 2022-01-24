//
//  MainButtonStyle.swift
//  UICore
//
//  Created by Ihor Yarovyi on 8/14/21.
//

import SwiftUI
import Resources

public struct MainButtonStyle: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .frame(height: Defaults.height)
            .foregroundColor(.white)
            .background(Color(Colors.fadedOrange.color))
            .cornerRadius(Defaults.cornerRadius)
    }
}

public extension View {
    func mainButton() -> some View {
        modifier(MainButtonStyle())
    }
}

// MARK: - Defaults
private extension MainButtonStyle {
    enum Defaults {
        static let cornerRadius: CGFloat = 4
        static let height: CGFloat = 44
    }
}
