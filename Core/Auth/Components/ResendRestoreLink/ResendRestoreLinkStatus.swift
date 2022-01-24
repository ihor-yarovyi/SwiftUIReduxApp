//
//  
//  ResendRestoreLinkStatus.swift
//  Core
//
//  Created by Ihor Yarovyi on 1/3/22.
//
//

import Foundation

public enum ResendRestoreLinkStatus {
    case none
    case inProgress
    case failed(Error)
    case success
    
    init() {
        self = .none
    }
    
    mutating func reduce(_ action: Action) {
        switch action {
        case is Actions.ResendRestoreLink.Resend:
            self = .inProgress
        case let action as Actions.ResendRestoreLink.DidFail:
            self = .failed(action.error)
        case is Actions.RestorePassword.OnDisappear,
            is Actions.ResendRestoreLink.DidResend:
            self = .none
        default:
            break
        }
    }
}
