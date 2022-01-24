//
//  
//  RestorePassword.StatusView+Connector.swift
//  RestorePassword
//
//  Created by Ihor Yarovyi on 02.01.2022.
//
//

import SwiftUI
import Redux
import Core

public extension RestorePassword.StatusView {
    struct Connector: Redux.Connector {
        public init() {}

        public func map(graph: Graph) -> some View {
            RestorePassword.StatusView(
                email: graph.restorePassword.email,
                resendAction: .available(graph.restorePassword.resendLink),
                signInAction: .available(graph.restorePassword.disappearRestorePasswordForm),
                screenProgress: graph.restorePassword.statusViewProgress
            )
        }
    }
}

extension RestorePasswordNode {
    var statusViewProgress: RestorePassword.StatusView.Progress {
        switch resendLinkProgress {
        case .none:
            return .none
        case .inProgress:
            return .active
        case .success:
            return .none
        case let .failed(error):
            return .failed(error)
        }
    }
}
