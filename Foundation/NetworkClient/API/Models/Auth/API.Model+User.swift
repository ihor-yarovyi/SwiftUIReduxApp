//
//  API.Model+User.swift
//  NetworkClient
//
//  Created by Ihor Yarovyi on 8/23/21.
//

import Foundation

public extension NetworkClient.API.Model {
    struct User: Codable {
        public let id: Int
        public let createdAt: String
        public let updatedAt: String
        public let email: String?
        public let username: String
        
        public init(id: Int,
                    createdAt: String,
                    updatedAt: String,
                    email: String?,
                    username: String) {
            self.id = id
            self.createdAt = createdAt
            self.updatedAt = updatedAt
            self.email = email
            self.username = username
        }
    }
}
