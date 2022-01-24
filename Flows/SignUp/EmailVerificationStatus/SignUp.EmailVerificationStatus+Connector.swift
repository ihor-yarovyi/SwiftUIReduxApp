//
//  
//  SignUp.EmailVerificationStatus+Connector.swift
//  SignUp
//
//  Created by Ihor Yarovyi on 10/3/21.
//
//

import SwiftUI
import Redux
import Core

public extension SignUp.EmailVerificationStatus {
    struct Connector: Redux.Connector {
        public init() {}

        public func map(graph: Graph) -> some View {
            SignUp.EmailVerificationStatus(
                screenProgress: graph.signUpForm.progress,
                onSuccess: SignUp.CompleteProfile.Connector().eraseToAnyView()
            )
        }
    }
}

private extension SignUpFormNode {
    var progress: SignUp.EmailVerificationStatus.Progress {
        switch emailVerificationProgress {
        case .none, .inProgress, .success:
            return .success
        case .failed:
            return .failed
        }
    }
}
