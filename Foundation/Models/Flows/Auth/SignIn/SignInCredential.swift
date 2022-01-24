//
//  SignInCredential.swift
//  Models
//
//  Created by Ihor Yarovyi on 8/17/21.
//

import Foundation

public extension Models.Auth {
    struct SignInCredential {
        public let email: Email
        public let password: Password
        
        public init(email: Email, password: Password) {
            self.email = email
            self.password = password
        }
    }
}
