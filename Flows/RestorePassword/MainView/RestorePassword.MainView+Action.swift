//
//  
//  RestorePassword.MainView+Action.swift
//  RestorePassword
//
//  Created by Ihor Yarovyi on 01.01.2022.
//
//

import Redux

public extension RestorePassword.MainView {
    enum Action {
        case available(Command)
        case unavailable
    }
}
