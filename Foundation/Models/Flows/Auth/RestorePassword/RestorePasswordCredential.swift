//
//  RestorePasswordCredential.swift
//  Models
//
//  Created by Ihor Yarovyi on 1/4/22.
//

import Foundation

public extension Models.Auth {
    struct RestorePasswordCredential {
        public let password: Password
        public let confirmPassword: ConfirmPassword
        
        public init(password: Password,
                    confirmPassword: ConfirmPassword) {
            self.password = password
            self.confirmPassword = confirmPassword
        }
    }
}
