//
//  
//  RestorePassword+UpdateCredential.swift
//  Core
//
//  Created by Ihor Yarovyi on 02.01.2022.
//
//

import Models

public extension Actions.RestorePassword {
    struct UpdateCredential: Action {
        let email: Models.Auth.Email
        
        public init(email: Models.Auth.Email) {
            self.email = email
        }
    }
}
