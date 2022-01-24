//
//  
//  RestoreSessionFlow.swift
//  Core
//
//  Created by Ihor Yarovyi on 9/2/21.
//
//

import Foundation

public enum RestoreSessionFlow {
    case none
    case fetchFromKeychain
    case fetchUserFromDB
    
    init() {
        self = .none
    }

    mutating func reduce(_ action: Action) {
        switch action {
        case is Actions.Session.RestoreSession:
            self = .fetchFromKeychain
        case is Actions.Session.FetchedSession:
            self = .fetchUserFromDB
        case is Actions.Session.SessionNotAvailable,
            is Actions.Session.SessionExpired,
            is Actions.Session.UserExists,
            is Actions.Session.UserDoesNotExist:
            self = .none
        default:
            break
        }
    }
}
