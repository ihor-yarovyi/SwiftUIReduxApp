//
//  
//  SignUpFormNode.swift
//  Core
//
//  Created by Ihor Yarovyi on 9/10/21.
//
//

import Models

public extension Graph {
    var signUpForm: SignUpFormNode {
        SignUpFormNode(graph: self)
    }
}

public struct SignUpFormNode {
    let graph: Graph

    public var email: String {
        get {
            graph.state.signUpForm.email
        }
        nonmutating set {
            graph.dispatch(Actions.SignUp.UpdateRawEmail(email: newValue))
        }
    }
    
    public var username: String {
        get {
            graph.state.signUpForm.username
        }
        nonmutating set {
            graph.dispatch(Actions.SignUp.UpdateRawUsername(username: newValue))
        }
    }
    
    public var password: String {
        get {
            graph.state.signUpForm.password
        }
        nonmutating set {
            graph.dispatch(Actions.SignUp.UpdateRawPassword(password: newValue))
        }
    }
    
    public var confirmPassword: String {
        get {
            graph.state.signUpForm.confirmPassword
        }
        nonmutating set {
            graph.dispatch(Actions.SignUp.UpdateRawConfirmPassword(confirmPassword: newValue))
        }
    }
    
    public var progress: SignUpStatus {
        graph.state.signUpStatus
    }
    
    public var resendEmailProgress: ResendEmailVerificationStatus {
        graph.state.resentEmailStatus
    }
    
    public var emailVerificationProgress: EmailVerificationStatus {
        graph.state.emailVerificationStatus
    }
    
    public var hasVerificationResult: Bool {
        if case .none = emailVerificationProgress {
            return false
        } else if case .inProgress = emailVerificationProgress {
            return false
        }
        return true
    }

    public func signUp() {
        graph.dispatch(Actions.SignUp.SignUp())
    }
    
    public func onDisappear() {
        graph.dispatch(Actions.SignUp.OnDisappear())
    }
    
    public func onDisapperEmailVerification() {
        graph.dispatch(Actions.ResendEmailVerification.OnDisappear())
    }
    
    public func resendEmail() {
        graph.dispatch(Actions.ResendEmailVerification.ResendEmail())
    }
}
