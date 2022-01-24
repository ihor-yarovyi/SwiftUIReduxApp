//
//  SignIn+UpdateRawUsername.swift
//  Core
//
//  Created by Ihor Yarovyi on 8/15/21.
//

import Foundation

public extension Actions.SignIn {
    struct UpdateRawUsername: Action {
        public let email: String
        
        public init(email: String) {
            self.email = email
        }
    }
}
