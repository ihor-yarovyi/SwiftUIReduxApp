//
//  
//  RestorePassword.StatusView+Action.swift
//  RestorePassword
//
//  Created by Ihor Yarovyi on 02.01.2022.
//
//

import Redux

public extension RestorePassword.StatusView {
    enum Action {
        case available(Command)
        case unavailable
    }
}
