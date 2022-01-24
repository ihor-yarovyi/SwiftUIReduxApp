//
//  
//  Session+FetchedSession.swift
//  Core
//
//  Created by Ihor Yarovyi on 9/2/21.
//
//

import Models

public extension Actions.Session {
    struct FetchedSession: Action {
        public let session: Models.Auth.SignInSession
        
        public init(_ session: Models.Auth.SignInSession) {
            self.session = session
        }
    }
}
