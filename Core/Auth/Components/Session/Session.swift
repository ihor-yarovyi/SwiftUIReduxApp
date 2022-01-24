//
//  Session.swift
//  Core
//
//  Created by Ihor Yarovyi on 8/28/21.
//

import Models

public struct Session {
    public var session: Models.Auth.SignInSession?
    public var userSaved: Bool = false
    
    mutating func reduce(_ action: Action) {
        switch action {
        case let action as Actions.Session.ReceiveSession:
            session = action.signInSession
        case let action as Actions.Session.FetchedSession:
            session = action.session
        case is Actions.SignIn.DidSignIn,
            is Actions.Session.UserExists:
            userSaved = true
        case is Actions.Session.UserDoesNotExist,
            is Actions.Session.SignOut:
            self = Session()
        default:
            break
        }
    }
}
