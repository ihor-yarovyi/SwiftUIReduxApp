//
//  SignIn+Connector.swift
//  SignIn
//
//  Created by Ihor Yarovyi on 8/18/21.
//

import SwiftUI
import Redux
import Core
import SignUp
import RestorePassword

public extension SignIn {
    struct Connector: Redux.Connector {
        public init() {}
        
        public func map(graph: Graph) -> some View {
            MainView(
                email: Binding(get: {
                    graph.signInForm.email
                }, set: {
                    graph.signInForm.email = $0
                }),
                password: Binding(get: {
                    graph.signInForm.password
                }, set: {
                    graph.signInForm.password = $0
                }),
                signInAction: .available(graph.signInForm.signIn),
                signInProgress: graph.signInForm.signInProgress,
                onSignUp: SignUp.Connector().eraseToAnyView(),
                onRestorePassword: RestorePassword.Connector().eraseToAnyView()
            )
        }
    }
}

extension SignInFormNode {
    var signInProgress: SignIn.MainView.Progress {
        switch progress {
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
