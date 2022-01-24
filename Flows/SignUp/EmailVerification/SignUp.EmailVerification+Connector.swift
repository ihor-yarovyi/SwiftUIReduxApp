//
//  
//  SignUp.EmailVerification+Connector.swift
//  SignUp
//
//  Created by Ihor Yarovyi on 9/19/21.
//
//

import SwiftUI
import Redux
import Core

public extension SignUp.EmailVerification {
    struct Connector: Redux.Connector {
        public init() {}

        public func map(graph: Graph) -> some View {
            SignUp.EmailVerification(
                email: graph.signUpForm.email,
                disappearAction: .available(graph.signUpForm.onDisapperEmailVerification),
                resendAction: .available(graph.signUpForm.resendEmail),
                signInAction: .available(graph.signUpForm.onDisappear),
                screenProgress: graph.signUpForm.resendEmailScreenProgress
            )
        }
    }
}

extension SignUpFormNode {
    var resendEmailScreenProgress: SignUp.EmailVerification.Progress {
        switch resendEmailProgress {
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
