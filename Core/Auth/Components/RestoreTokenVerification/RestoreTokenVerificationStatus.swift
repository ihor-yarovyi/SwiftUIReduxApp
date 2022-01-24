//
//  
//  RestoreTokenVerificationStatus.swift
//  Core
//
//  Created by Ihor Yarovyi on 1/3/22.
//
//

import Foundation

public enum RestoreTokenVerificationStatus {
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
            if case .restorePassword = action.kind {
                self = .inProgress
            } else {
                self = .none
            }
        case is Actions.RestoreTokenVerification.DidVerify:
            self = .success
        case let action as Actions.RestoreTokenVerification.DidFail:
            self = .failed(action.error)
        default:
            break
        }
    }
}
