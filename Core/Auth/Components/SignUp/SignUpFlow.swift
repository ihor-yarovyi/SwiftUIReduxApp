//
//  
//  SignUpFlow.swift
//  Core
//
//  Created by Ihor Yarovyi on 9/10/21.
//
//

import Foundation

public enum SignUpFlow {
    case none
    case validation
    case signUp(UUID)
    
    init() {
        self = .none
    }

    mutating func reduce(_ action: Action) {
        switch action {
        case is Actions.SignUp.SignUp:
            self = .validation
        case is Actions.SignUp.CredentialsValidated:
            self = .signUp(UUID())
        case is Actions.SignUp.InvalidCredential,
            is Actions.SignUp.InvalidSignUpRequest,
            is Actions.SignUp.DidSendSignUp,
            is Actions.SignUp.OnDisappear,
            is Actions.SignUp.UpdateCredential:
            self = .none
        default:
            break
        }
    }
}
