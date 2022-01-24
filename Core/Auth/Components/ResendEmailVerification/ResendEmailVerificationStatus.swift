//
//  
//  ResendEmailVerificationStatus.swift
//  Core
//
//  Created by Ihor Yarovyi on 9/28/21.
//
//

import Foundation

public enum ResendEmailVerificationStatus {
    case none
    case inProgress
    case failed(Error)
    case success
    
    init() {
        self = .none
    }

    mutating func reduce(_ action: Action) {
        switch action {
        case is Actions.ResendEmailVerification.ResendEmail:
            self = .inProgress
        case is Actions.ResendEmailVerification.DidSendEmail:
            self = .success
        case let action as Actions.ResendEmailVerification.DidFailSend:
            self = .failed(action.error)
        case is Actions.ResendEmailVerification.OnDisappear:
            self = .none
        default:
            break
        }
    }
}
