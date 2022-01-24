//
//  
//  RestorePasswordForm.swift
//  Core
//
//  Created by Ihor Yarovyi on 02.01.2022.
//
//

import Models

public struct RestorePasswordForm {
    public var rawEmail: String = ""
    public var email: Models.Auth.Email?

    mutating func reduce(_ action: Action) {
        switch action {
        case let action as Actions.RestorePassword.UpdateRawEmail:
            rawEmail = action.email
        case let action as Actions.RestorePassword.UpdateCredential:
            email = action.email
        case is Actions.RestorePassword.OnDisappear:
            self = Self()
        default:
            break
        }
    }
}
