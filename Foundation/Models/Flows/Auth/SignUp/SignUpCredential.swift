//
//  SignUpCredential.swift
//  Models
//
//  Created by Ihor Yarovyi on 9/11/21.
//

import Foundation

public extension Models.Auth {
    struct SignUpCredential {
        public let email: Email
        public let username: Username
        public let password: Password
        public let confirmPassword: ConfirmPassword
        
        public init(email: Email,
                    username: Username,
                    password: Password,
                    confirmPassword: ConfirmPassword) {
            self.email = email
            self.username = username
            self.password = password
            self.confirmPassword = confirmPassword
        }
    }
}
