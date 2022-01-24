//
//  
//  SignUpForm.swift
//  Core
//
//  Created by Ihor Yarovyi on 9/9/21.
//
//

import Models

public struct SignUpForm {
    public var email: String = ""
    public var username: String = ""
    public var password: String = ""
    public var confirmPassword: String = ""
    public var credential: Models.Auth.SignUpCredential?

    mutating func reduce(_ action: Action) {
        switch action {
        case let action as Actions.SignUp.UpdateRawEmail:
            email = action.email
        case let action as Actions.SignUp.UpdateRawUsername:
            username = action.username
        case let action as Actions.SignUp.UpdateRawPassword:
            password = action.password
        case let action as Actions.SignUp.UpdateRawConfirmPassword:
            confirmPassword = action.confirmPassword
        case let action as Actions.SignUp.UpdateCredential:
            credential = action.credential
        case is Actions.Session.SignOut,
            is Actions.SignUp.OnDisappear:
            self = Self()
        default:
            break
        }
    }
}
