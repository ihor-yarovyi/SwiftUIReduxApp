//
//  
//  RestorePasswordStatus.swift
//  Core
//
//  Created by Ihor Yarovyi on 02.01.2022.
//
//

import Foundation

public enum RestorePasswordStatus {
    case none
    case inProgress
    case failed(Error)
    case success
    
    init() {
        self = .none
    }

    mutating func reduce(_ action: Action) {
        switch action {
        case is Actions.RestorePassword.Restore:
            self = .inProgress
        case is Actions.RestorePassword.DidSendRequest:
            self = .success
        case let action as Actions.RestorePassword.Failed:
            self = .failed(action.error)
        case is Actions.RestorePassword.OnDisappear:
            self = .none
        default:
            break
        }
    }
}
