//
//  
//  RestorePassword+Connector.swift
//  RestorePassword
//
//  Created by Ihor Yarovyi on 01.01.2022.
//
//

import SwiftUI
import Redux
import Core

public extension RestorePassword {
    struct Connector: Redux.Connector {
        public init() {}

        public func map(graph: Graph) -> some View {
            MainView(
                email: Binding(get: {
                    graph.restorePassword.email
                }, set: {
                    graph.restorePassword.email = $0
                }),
                restorePasswordAction: .available(graph.restorePassword.restorePassword),
                disappearAction: .available(graph.restorePassword.disappearRestorePasswordForm),
                screenProgress: graph.restorePassword.screenProgress,
                onRestorePassword: StatusView.Connector().eraseToAnyView()
            )
        }
    }
}

extension RestorePasswordNode {
    var screenProgress: RestorePassword.MainView.Progress {
        switch progress {
        case .none:
            return .none
        case .inProgress:
            return .active
        case .success:
            return .success
        case let .failed(error):
            return .failed(error)
        }
    }
}
