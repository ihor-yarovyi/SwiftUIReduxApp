//
//  
//  NewPassword+UpdateCredential.swift
//  Core
//
//  Created by Ihor Yarovyi on 1/4/22.
//
//

import Models

public extension Actions.NewPassword {
    struct UpdateCredential: Action {
        let credential: Models.Auth.RestorePasswordCredential
        
        public init(_ credential: Models.Auth.RestorePasswordCredential) {
            self.credential = credential
        }
    }
}
