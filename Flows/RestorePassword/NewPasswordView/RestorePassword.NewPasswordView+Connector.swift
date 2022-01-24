//
//  
//  RestorePassword.NewPasswordView+Connector.swift
//  RestorePassword
//
//  Created by Ihor Yarovyi on 1/3/22.
//
//

import SwiftUI
import Redux
import Core

public extension RestorePassword.NewPasswordView {
    struct Connector: Redux.Connector {
        public init() {}

        public func map(graph: Graph) -> some View {
            RestorePassword.NewPasswordView(
                password: Binding(get: {
                    graph.restorePassword.password
                }, set: {
                    graph.restorePassword.password = $0
                }),
                confirmPassword: Binding(get: {
                    graph.restorePassword.confirmPassword
                }, set: {
                    graph.restorePassword.confirmPassword = $0
                }),
                restorePasswordAction: .available(graph.restorePassword.passNewPassword),
                disapeearAction: .available(graph.restorePassword.disappearNewPasswordForm),
                screenProgress: graph.restorePassword.newPasswordScreenProgress
            )
        }
    }
}

extension RestorePasswordNode {
    var newPasswordScreenProgress: RestorePassword.NewPasswordView.Progress {
        switch newPasswordProgress {
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
