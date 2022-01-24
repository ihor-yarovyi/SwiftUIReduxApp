//
//  Session+ReceiveSession.swift
//  Core
//
//  Created by Ihor Yarovyi on 8/25/21.
//

import Foundation
import Models

public extension Actions.Session {
    struct ReceiveSession: Action {
        public let signInSession: Models.Auth.SignInSession
        
        public init(_ signInSession: Models.Auth.SignInSession) {
            self.signInSession = signInSession
        }
    }
}
