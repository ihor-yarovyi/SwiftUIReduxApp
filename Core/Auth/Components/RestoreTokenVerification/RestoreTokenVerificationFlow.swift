//
//  
//  RestoreTokenVerificationFlow.swift
//  Core
//
//  Created by Ihor Yarovyi on 1/3/22.
//
//

import Foundation

public enum RestoreTokenVerificationFlow {
    case none
    case verifyToken(UUID, token: String)
    
    init() {
        self = .none
    }
    
    mutating func reduce(_ action: Action) {
        switch action {
        case let action as Actions.DeepLink.DidReceive:
            if case let .restorePassword(token) = action.kind {
                self = .verifyToken(UUID(), token: token)
            } else {
                self = .none
            }
        default:
            break
        }
    }
}
