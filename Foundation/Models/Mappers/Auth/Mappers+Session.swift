//
//  Mappers+Session.swift
//  Models
//
//  Created by Ihor Yarovyi on 8/25/21.
//

import Foundation
import NetworkClient

public extension Models.Mappers.Auth {
    static func map(_ session: NetworkClient.API.Model.Session) -> Models.Auth.Session {
        .init(
            accessToken: session.accessToken,
            refreshToken: session.refreshToken,
            expiresAt: session.expiresAt
        )
    }
    
    static func map(_ session: Models.Auth.Session) -> NetworkClient.API.Model.Session {
        .init(
            accessToken: session.accessToken,
            refreshToken: session.refreshToken,
            expiresAt: session.expiresAt
        )
    }
}
