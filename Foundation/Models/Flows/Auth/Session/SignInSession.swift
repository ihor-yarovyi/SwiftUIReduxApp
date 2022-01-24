//
//  SignInSession.swift
//  Models
//
//  Created by Ihor Yarovyi on 8/25/21.
//

import Foundation

public extension Models.Auth {
    struct SignInSession {
        public let session: Session
        public let user: User
        
        public init(session: Session, user: User) {
            self.session = session
            self.user = user
        }
    }
}
