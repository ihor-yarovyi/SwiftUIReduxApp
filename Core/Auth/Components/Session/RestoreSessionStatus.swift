//
//  
//  RestoreSessionStatus.swift
//  Core
//
//  Created by Ihor Yarovyi on 9/2/21.
//
//

import Foundation

public enum RestoreSessionStatus {
    case none
    case inProgress
    case failed
    case success
    
    init() {
        self = .none
    }

    mutating func reduce(_ action: Action) {
        switch action {
        case is Actions.Session.RestoreSession:
            self = .inProgress
        case is Actions.Session.SessionNotAvailable,
            is Actions.Session.SessionExpired,
            is Actions.Session.UserDoesNotExist:
            self = .failed
        case is Actions.Session.UserExists:
            self = .success
        default:
            break
        }
    }
}
