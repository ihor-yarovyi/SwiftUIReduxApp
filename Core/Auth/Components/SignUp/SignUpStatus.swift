//
//  
//  SignUpStatus.swift
//  Core
//
//  Created by Ihor Yarovyi on 9/9/21.
//
//

import Foundation

public enum SignUpStatus {
    case none
    case inProgress
    case failed(Error)
    case success
    
    init() {
        self = .none
    }

    mutating func reduce(_ action: Action) {
        switch action {
        case is Actions.SignUp.SignUp:
            self = .inProgress
        case let action as Actions.SignUp.InvalidCredential:
            self = .failed(action.error)
        case let action as Actions.SignUp.InvalidSignUpRequest:
            self = .failed(action.error)
        case is Actions.SignUp.DidSendSignUp:
            self = .success
        case is Actions.Session.SignOut,
            is Actions.SignUp.OnDisappear:
            self = .none
        default:
            break
        }
    }
}
