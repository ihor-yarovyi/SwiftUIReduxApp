//
//  
//  CompleteProfile+UpdateCredential.swift
//  Core
//
//  Created by Ihor Yarovyi on 11/3/21.
//
//

import Models

public extension Actions.CompleteProfile {
    struct UpdateCredential: Action {
        let credential: Models.Auth.CompleteProfileCredential
        
        public init(_ credential: Models.Auth.CompleteProfileCredential) {
            self.credential = credential
        }
    }
}
