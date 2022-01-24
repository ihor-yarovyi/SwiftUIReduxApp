//
//  
//  RestorePassword.NewPasswordView+Action.swift
//  RestorePassword
//
//  Created by Ihor Yarovyi on 1/3/22.
//
//

import Redux

public extension RestorePassword.NewPasswordView {
    enum Action {
        case available(Command)
        case unavailable
    }
}
