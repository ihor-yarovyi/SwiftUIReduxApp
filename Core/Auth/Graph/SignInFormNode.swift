//
//  SignInFormNode.swift
//  Core
//
//  Created by Ihor Yarovyi on 8/16/21.
//

import Models

public extension Graph {
    var signInForm: SignInFormNode {
        SignInFormNode(graph: self)
    }
}

public struct SignInFormNode {
    let graph: Graph
    
    public var email: String {
        get {
            graph.state.signInForm.email
        }
        nonmutating set {
            graph.dispatch(Actions.SignIn.UpdateRawUsername(email: newValue))
        }
    }
    
    public var password: String {
        get {
            graph.state.signInForm.password
        }
        nonmutating set {
            graph.dispatch(Actions.SignIn.UpdateRawPassword(password: newValue))
        }
    }
    
    public var credential: Models.Auth.SignInCredential? {
        get {
            graph.state.signInForm.credential
        }
        nonmutating set {
            newValue.flatMap {
                graph.dispatch(Actions.SignIn.UpdateCredential(credential: $0))
            }
        }
    }
    
    public var progress: SignInStatus {
        graph.state.signInStatus
    }
    
    public var isCredentialsOk: Bool {
        graph.state.signInForm.isCredentialOk
    }
    
    public func signIn() {
        graph.dispatch(Actions.SignIn.SignIn())
    }
}
