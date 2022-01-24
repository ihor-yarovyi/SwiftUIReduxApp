//
//  SignInFlow.swift
//  Core
//
//  Created by Ihor Yarovyi on 8/18/21.
//

import Foundation

public enum SignInFlow {
    case none
    case validation
    case signIn(UUID)
    case saveSessionToKeychain
    case saveUser
    
    init() {
        self = .none
    }
    
    mutating func reduce(_ action: Action) {
        switch action {
        case is Actions.SignIn.SignIn:
            self = .validation
        case is Actions.SignIn.CredentialsValidated:
            self = .signIn(UUID())
        case is Actions.Session.ReceiveSession:
            self = .saveSessionToKeychain
        case is Actions.SignIn.SaveUser:
            self = .saveUser
        case is Actions.SignIn.FailedSaveUser,
            is Actions.SignIn.InvalidCredentials,
            is Actions.SignIn.BadSignInRequest,
            is Actions.SignIn.DidSignIn,
            is Actions.SignIn.UpdateCredential:
            self = .none
        default:
            break
        }
    }
}
