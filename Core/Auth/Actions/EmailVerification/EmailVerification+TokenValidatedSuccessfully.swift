//
//  
//  EmailVerification+TokenValidatedSuccessfully.swift
//  Core
//
//  Created by Ihor Yarovyi on 10/3/21.
//
//

import Models

public extension Actions.EmailVerification {
    struct TokenValidatedSuccessfully: Action {
        public let session: Models.Auth.Session
        
        public init(session: Models.Auth.Session) {
            self.session = session
        }
    }
}
