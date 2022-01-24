//
//  
//  UpdateRawPassword.swift
//  Core
//
//  Created by Ihor Yarovyi on 9/10/21.
//
//

import Foundation

public extension Actions.SignUp {
    struct UpdateRawPassword: Action {
        let password: String
        
        public init(password: String) {
            self.password = password
        }
    }
}
