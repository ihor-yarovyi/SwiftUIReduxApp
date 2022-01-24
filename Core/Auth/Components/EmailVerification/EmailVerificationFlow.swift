//
//  
//  EmailVerificationFlow.swift
//  Core
//
//  Created by Ihor Yarovyi on 10/3/21.
//
//

import Foundation

public enum EmailVerificationFlow {
    case none
    case verifyToken(UUID, token: String)
    
    init() {
        self = .none
    }

    mutating func reduce(_ action: Action) {
        switch action {
        case let action as Actions.DeepLink.DidReceive:
            if case let .verifiedEmail(token) = action.kind {
                self = .verifyToken(UUID(), token: token)
            } else {
                self = .none
            }
        case is Actions.EmailVerification.TokenValidatedSuccessfully,
            is Actions.EmailVerification.TokenIsInvalid:
            self = .none
        default:
            break
        }
    }
}
