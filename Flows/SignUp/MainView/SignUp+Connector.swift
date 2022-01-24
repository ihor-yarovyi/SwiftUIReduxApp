//
//  
//  SignUp+Connector.swift
//  SignUp
//
//  Created by Ihor Yarovyi on 9/6/21.
//
//

import SwiftUI
import Redux
import Core

public extension SignUp {
    struct Connector: Redux.Connector {
        public init() {}

        public func map(graph: Graph) -> some View {
            MainView(
                email: Binding(get: {
                    graph.signUpForm.email
                }, set: {
                    graph.signUpForm.email = $0
                }),
                username: Binding(get: {
                    graph.signUpForm.username
                }, set: {
                    graph.signUpForm.username = $0
                }),
                password: Binding(get: {
                    graph.signUpForm.password
                }, set: {
                    graph.signUpForm.password = $0
                }),
                confirmPassword: Binding(get: {
                    graph.signUpForm.confirmPassword
                }, set: {
                    graph.signUpForm.confirmPassword = $0
                }),
                screenAction: .available(graph.signUpForm.signUp),
                signInAction: .available(graph.signUpForm.onDisappear),
                screenProgress: graph.signUpForm.screenProgress,
                onEmailVerification: SignUp.EmailVerification.Connector().eraseToAnyView()
            )
        }
    }
}

extension SignUpFormNode {
    var screenProgress: SignUp.MainView.Progress {
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
