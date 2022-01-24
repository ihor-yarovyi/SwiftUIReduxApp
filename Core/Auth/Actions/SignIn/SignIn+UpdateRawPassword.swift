//
//  SignIn+UpdateRawPassword.swift
//  Core
//
//  Created by Ihor Yarovyi on 8/15/21.
//

import Foundation

public extension Actions.SignIn {
    struct UpdateRawPassword: Action {
        public let password: String
        
        public init(password: String) {
            self.password = password
        }
    }
}
