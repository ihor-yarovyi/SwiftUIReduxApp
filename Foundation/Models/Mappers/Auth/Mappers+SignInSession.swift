//
//  Mappers+SignInSession.swift
//  Models
//
//  Created by Ihor Yarovyi on 8/25/21.
//

import Foundation
import NetworkClient

public extension Models.Mappers.Auth {
    static func map(_ signInSession: NetworkClient.API.Model.SignInSession) -> Models.Auth.SignInSession {
        .init(
            session: Models.Mappers.Auth.map(signInSession.session),
            user: Models.Mappers.Auth.map(signInSession.user)
        )
    }
    
    static func map(_ signInSession: Models.Auth.SignInSession) -> NetworkClient.API.Model.SignInSession {
        .init(
            session: Models.Mappers.Auth.map(signInSession.session),
            user: Models.Mappers.Auth.map(signInSession.user)
        )
    }
}
