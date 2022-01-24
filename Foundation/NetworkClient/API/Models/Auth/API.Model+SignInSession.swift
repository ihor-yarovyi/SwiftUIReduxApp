//
//  API.Model+SignInSession.swift
//  NetworkClient
//
//  Created by Ihor Yarovyi on 8/23/21.
//

import Foundation

public extension NetworkClient.API.Model {
    struct SignInSession: Codable {
        public let session: Session
        public let user: User
        
        public init(session: Session, user: User) {
            self.session = session
            self.user = user
        }
    }
}
