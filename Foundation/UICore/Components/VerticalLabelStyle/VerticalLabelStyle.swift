//
//  VerticalLabelStyle.swift
//  SignUp
//
//  Created by Ihor Yarovyi on 10/10/21.
//

import SwiftUI

public struct VerticalLabelStyle: LabelStyle {
    public let spacing: CGFloat
    
    public init(spacing: CGFloat = 8) {
        self.spacing = spacing
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .center, spacing: spacing) {
            configuration.icon
            configuration.title
        }
    }
}
