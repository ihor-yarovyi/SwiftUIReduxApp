//
//  
//  NewPasswordStatus.swift
//  Core
//
//  Created by Ihor Yarovyi on 1/4/22.
//
//

import Foundation

public enum NewPasswordStatus {
    case none
    case inProgress
    case failed(Error)
    case success
    
    init() {
        self = .none
    }
    
    mutating func reduce(_ action: Action) {
        switch action {
        case is Actions.NewPassword.Restore:
            self = .inProgress
        case is Actions.NewPassword.Success:
            self = .success
        case let action as Actions.NewPassword.Failed:
            self = .failed(action.error)
        case is Actions.NewPassword.Disappear:
            self = .none
        default:
            break
        }
    }
}
