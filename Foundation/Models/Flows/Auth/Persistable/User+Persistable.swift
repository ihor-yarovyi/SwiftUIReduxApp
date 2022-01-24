//
//  User+Persistable.swift
//  Models
//
//  Created by Ihor Yarovyi on 8/28/21.
//

import DatabaseClient

extension Models.Auth.User: Persistable {
    public func update(_ object: DatabaseClient.Models.CDUser) {
        object.id = Int64(id)
        object.createdAt = createdAt
        object.updatedAt = updatedAt
        object.username = username
        object.email = email
    }
}
