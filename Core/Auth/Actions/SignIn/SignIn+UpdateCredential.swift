//
//  SignIn+UpdateCredential.swift
//  Core
//
//  Created by Ihor Yarovyi on 8/18/21.
//

import Models

public extension Actions.SignIn {
    struct UpdateCredential: Action {
        public let credential: Models.Auth.SignInCredential
        
        public init(credential: Models.Auth.SignInCredential) {
            self.credential = credential
        }
    }
}
