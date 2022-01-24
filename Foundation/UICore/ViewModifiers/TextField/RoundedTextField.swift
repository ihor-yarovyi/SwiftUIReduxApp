//
//  RoundedTextField.swift
//  UICore
//
//  Created by Ihor Yarovyi on 8/14/21.
//

import SwiftUI

public struct RoundedTextField: ViewModifier {
    
    public let foregroundColor: Color
    
    public func body(content: Content) -> some View {
        content
            .padding(insets)
            .background(Color.white)
            .overlay(fieldOverlay)
            .frame(height: Defaults.height)
    }
    
    // MARK: - Private Properties
    private var fieldOverlay: some View {
        RoundedRectangle(cornerRadius: Defaults.cornerRadius)
            .stroke(lineWidth: Defaults.lineWidth)
            .foregroundColor(foregroundColor)
    }
    
    private let insets = EdgeInsets(top: Defaults.topInset,
                                    leading: Defaults.leadingInset,
                                    bottom: Defaults.bottomInset,
                                    trailing: Defaults.trailingInset)
}

public extension View {
    func roundedTextField(foregroundColor: Color = Color.blue) -> some View {
        modifier(RoundedTextField(foregroundColor: foregroundColor))
    }
}

// MARK: - Defaults
private extension RoundedTextField {
    enum Defaults {
        static let cornerRadius: CGFloat = 4
        static let lineWidth: CGFloat = 1
        static let height: CGFloat = 44
        static let topInset: CGFloat = 8
        static let bottomInset: CGFloat = 8
        static let leadingInset: CGFloat = 16
        static let trailingInset: CGFloat = 16
    }
}
