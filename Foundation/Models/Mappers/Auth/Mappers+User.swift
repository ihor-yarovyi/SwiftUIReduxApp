//
//  Mappers+User.swift
//  Models
//
//  Created by Ihor Yarovyi on 8/25/21.
//

import NetworkClient
import DatabaseClient

public extension Models.Mappers {
    enum Auth {}
}

public extension Models.Mappers.Auth {
    static func map(_ user: NetworkClient.API.Model.User) -> Models.Auth.User {
        .init(
            id: user.id,
            createdAt: user.createdAt,
            updatedAt: user.updatedAt,
            email: user.email,
            username: user.username
        )
    }
    
    static func map(_ user: Models.Auth.User) -> NetworkClient.API.Model.User {
        .init(
            id: user.id,
            createdAt: user.createdAt,
            updatedAt: user.updatedAt,
            email: user.email,
            username: user.username
        )
    }
    
    static func map(_ user: DatabaseClient.Models.CDUser) -> Models.Auth.User {
        .init(
            id: Int(user.id),
            createdAt: user.createdAt,
            updatedAt: user.updatedAt,
            email: user.email,
            username: user.username
        )
    }
}
