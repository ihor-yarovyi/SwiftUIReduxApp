//
//  
//  RestorePasswordFlow.swift
//  Core
//
//  Created by Ihor Yarovyi on 02.01.2022.
//
//

import Foundation

public enum RestorePasswordFlow {
    case none
    case validation
    case restorePassword(UUID)
    
    init() {
        self = .none
    }

    mutating func reduce(_ action: Action) {
        switch action {
        case is Actions.RestorePassword.Restore:
            self = .validation
        case is Actions.RestorePassword.UpdateCredential:
            self = .restorePassword(UUID())
        case is Actions.RestorePassword.Failed,
            is Actions.RestorePassword.DidSendRequest,
            is Actions.RestorePassword.OnDisappear:
            self = .none
        default:
            break
        }
    }
}
