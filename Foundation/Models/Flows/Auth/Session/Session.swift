//
//  Session.swift
//  Models
//
//  Created by Ihor Yarovyi on 8/25/21.
//

import Foundation

public extension Models.Auth {
    struct Session {
        public let accessToken: String
        public let refreshToken: String
        public let expiresAt: Int
        
        public init(accessToken: String,
                    refreshToken: String,
                    expiresAt: Int) {
            self.accessToken = accessToken
            self.refreshToken = refreshToken
            self.expiresAt = expiresAt
        }
        
        public var isValid: Bool {
            let expirationDate = Date(timeInterval: TimeInterval(expiresAt), since: Date())
            return expirationDate > Date()
        }
    }
}
