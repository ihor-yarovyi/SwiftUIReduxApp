//
//  SignInStatus.swift
//  Core
//
//  Created by Ihor Yarovyi on 8/18/21.
//

import Foundation

public enum SignInStatus {
    case none
    case inProgress
    case failed(Error)
    case success
    
    init() {
        self = .none
    }
    
    mutating func reduce(_ action: Action) {
        switch action {
        case is Actions.SignIn.SignIn:
            self = .inProgress
        case let action as Actions.SignIn.InvalidCredentials:
            self = .failed(action.error)
        case let action as Actions.SignIn.BadSignInRequest:
            self = .failed(action.error)
        case let action as Actions.SignIn.FailedSaveUser:
            self = .failed(action.error)
        case is Actions.SignIn.DidSignIn:
            self = .success
        case is Actions.Session.SignOut:
            self = .none
        default:
            break
        }
    }
}
