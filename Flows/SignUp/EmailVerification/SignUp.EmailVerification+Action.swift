//
//  
//  SignUp.EmailVerification+Action.swift
//  SignUp
//
//  Created by Ihor Yarovyi on 9/13/21.
//
//

import Redux

public extension SignUp.EmailVerification {
    enum Action {
        case available(Command)
        case unavailable
    }
}
