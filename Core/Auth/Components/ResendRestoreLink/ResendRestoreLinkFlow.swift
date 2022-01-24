//
//  
//  ResendRestoreLinkFlow.swift
//  Core
//
//  Created by Ihor Yarovyi on 1/3/22.
//
//

import Foundation

public enum ResendRestoreLinkFlow {
    case none
    case resendRestoreLink(UUID)
    
    init() {
        self = .none
    }

    mutating func reduce(_ action: Action) {
        switch action {
        case is Actions.ResendRestoreLink.Resend:
            self = .resendRestoreLink(UUID())
        case is Actions.RestorePassword.OnDisappear,
            is Actions.ResendRestoreLink.DidResend,
            is Actions.ResendRestoreLink.DidFail:
            self = .none
        default:
            break
        }
    }
}
