//
//  
//  SignUp+UpdateCredential.swift
//  Core
//
//  Created by Ihor Yarovyi on 9/11/21.
//
//

import Models

public extension Actions.SignUp {
    struct UpdateCredential: Action {
        let credential: Models.Auth.SignUpCredential
        
        public init(credential: Models.Auth.SignUpCredential) {
            self.credential = credential
        }
    }
}
