//
//  
//  UpdateRawConfirmPassword.swift
//  Core
//
//  Created by Ihor Yarovyi on 9/10/21.
//
//

import Foundation

public extension Actions.SignUp {
    struct UpdateRawConfirmPassword: Action {
        let confirmPassword: String
        
        public init(confirmPassword: String) {
            self.confirmPassword = confirmPassword
        }
    }
}
