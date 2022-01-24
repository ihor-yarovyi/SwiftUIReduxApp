//
//  
//  ResendEmailVerificationFlow.swift
//  Core
//
//  Created by Ihor Yarovyi on 9/28/21.
//
//

import Foundation

public enum ResendEmailVerificationFlow {
    case none
    case resendEmail(UUID)
    
    init() {
        self = .none
    }

    mutating func reduce(_ action: Action) {
        switch action {
        case is Actions.ResendEmailVerification.ResendEmail:
            self = .resendEmail(UUID())
        case is Actions.ResendEmailVerification.DidSendEmail,
            is Actions.ResendEmailVerification.DidFailSend,
            is Actions.ResendEmailVerification.OnDisappear:
            self = .none
        default:
            break
        }
    }
}
