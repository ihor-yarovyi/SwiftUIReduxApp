//
//  
//  NewPasswordForm.swift
//  Core
//
//  Created by Ihor Yarovyi on 1/4/22.
//
//

import Models

public struct NewPasswordForm {
    public var token: String = ""
    public var password: String = ""
    public var confirmPassword: String = ""
    public var credential: Models.Auth.RestorePasswordCredential?

    mutating func reduce(_ action: Action) {
        switch action {
        case let action as Actions.RestoreTokenVerification.DidVerify:
            token = action.token
        case let action as Actions.NewPassword.UpdateRawPassword:
            password = action.rawPassword
        case let action as Actions.NewPassword.UpdateRawConfirmPassword:
            confirmPassword = action.rawConfirmPassword
        case let action as Actions.NewPassword.UpdateCredential:
            credential = action.credential
        case is Actions.NewPassword.Disappear:
            self = Self()
        default:
            break
        }
    }
}
