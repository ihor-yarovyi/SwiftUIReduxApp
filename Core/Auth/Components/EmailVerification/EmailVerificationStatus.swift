//
//  
//  EmailVerificationStatus.swift
//  Core
//
//  Created by Ihor Yarovyi on 10/3/21.
//
//

import Foundation

public enum EmailVerificationStatus {
    case none
    case inProgress
    case failed(Error)
    case success
    
    init() {
        self = .none
    }

    mutating func reduce(_ action: Action) {
        switch action {
        case let action as Actions.DeepLink.DidReceive:
            if case .verifiedEmail = action.kind {
                self = .inProgress
            } else {
                self = .none
            }
        case is Actions.EmailVerification.TokenValidatedSuccessfully:
            self = .success
        case let action as Actions.EmailVerification.TokenIsInvalid:
            self = .failed(action.error)
        case is Actions.CompleteProfile.Completed:
            self = .none
        default:
            break
        }
    }
}
