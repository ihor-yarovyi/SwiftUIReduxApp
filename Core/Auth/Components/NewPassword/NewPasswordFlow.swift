//
//  
//  NewPasswordFlow.swift
//  Core
//
//  Created by Ihor Yarovyi on 1/4/22.
//
//

import Foundation

public enum NewPasswordFlow {
    case none
    case validation
    case passNewPassword(UUID)
    
    init() {
        self = .none
    }
    
    mutating func reduce(_ action: Action) {
        switch action {
        case is Actions.NewPassword.Restore:
            self = .validation
        case is Actions.NewPassword.UpdateCredential:
            self = .passNewPassword(UUID())
        case is Actions.NewPassword.Success,
            is Actions.NewPassword.Failed,
            is Actions.NewPassword.Disappear:
            self = .none
        default:
            break
        }
    }
}
