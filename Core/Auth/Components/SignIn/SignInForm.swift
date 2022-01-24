//
//  SignInForm.swift
//  Core
//
//  Created by Ihor Yarovyi on 8/18/21.
//

import Models

public struct SignInForm {
    public var email: String = ""
    public var password: String = ""
    public var credential: Models.Auth.SignInCredential?
    
    public var isCredentialOk: Bool {
        credential != nil
    }
    
    mutating func reduce(_ action: Action) {
        switch action {
        case let action as Actions.SignIn.UpdateRawUsername:
            email = action.email
        case let action as Actions.SignIn.UpdateRawPassword:
            password = action.password
        case let action as Actions.SignIn.UpdateCredential:
            credential = action.credential
        case is Actions.Session.SignOut:
            self = Self()
        default:
            break
        }
    }
}
