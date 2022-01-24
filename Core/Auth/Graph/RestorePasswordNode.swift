//
//  
//  RestorePasswordNode.swift
//  Core
//
//  Created by Ihor Yarovyi on 02.01.2022.
//
//

import Models

public extension Graph {
    var restorePassword: RestorePasswordNode {
        RestorePasswordNode(graph: self)
    }
}

public struct RestorePasswordNode {
    let graph: Graph

    public var email: String {
        get {
            graph.state.restorePasswordForm.rawEmail
        }
        nonmutating set {
            graph.dispatch(Actions.RestorePassword.UpdateRawEmail(newValue))
        }
    }
    
    public var password: String {
        get {
            graph.state.newPasswordForm.password
        }
        nonmutating set {
            graph.dispatch(Actions.NewPassword.UpdateRawPassword(newValue))
        }
    }
    
    public var confirmPassword: String {
        get {
            graph.state.newPasswordForm.confirmPassword
        }
        nonmutating set {
            graph.dispatch(Actions.NewPassword.UpdateRawConfirmPassword(newValue))
        }
    }
    
    public var progress: RestorePasswordStatus {
        graph.state.restorePasswordStatus
    }
    
    public var resendLinkProgress: ResendRestoreLinkStatus {
        graph.state.resendRestoreLinkStatus
    }
    
    public var restoreTokenVerificationProgress: RestoreTokenVerificationStatus {
        graph.state.restoreTokenVerificationStatus
    }
    
    public var newPasswordProgress: NewPasswordStatus {
        graph.state.newPasswordStatus
    }
    
    public var hasVerificationResult: Bool {
        if case .none = restoreTokenVerificationProgress {
            return false
        } else if case .inProgress = restoreTokenVerificationProgress {
            return false
        }
        return true
    }

    public func restorePassword() {
        graph.dispatch(Actions.RestorePassword.Restore())
    }
    
    public func resendLink() {
        graph.dispatch(Actions.ResendRestoreLink.Resend())
    }
    
    public func disappearRestorePasswordForm() {
        graph.dispatch(Actions.RestorePassword.OnDisappear())
    }
    
    public func passNewPassword() {
        graph.dispatch(Actions.NewPassword.Restore())
    }
    
    public func disappearNewPasswordForm() {
        graph.dispatch(Actions.NewPassword.Disappear())
    }
}
