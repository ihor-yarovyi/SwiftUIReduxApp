//
//  AppState.swift
//  Core
//
//  Created by Ihor Yarovyi on 8/11/21.
//

import Foundation

public struct AppState {
    public var signInForm = SignInForm()
    public var signInFlow = SignInFlow()
    public var signInStatus = SignInStatus()
    public var session = Session()
    public var restoreSessionFlow = RestoreSessionFlow()
    public var restoreSessionStatus = RestoreSessionStatus()
    public var signUpForm = SignUpForm()
    public var signUpFlow = SignUpFlow()
    public var signUpStatus = SignUpStatus()
    public var resendEmailFlow = ResendEmailVerificationFlow()
    public var resentEmailStatus = ResendEmailVerificationStatus()
    public var emailVerificationFlow = EmailVerificationFlow()
    public var emailVerificationStatus = EmailVerificationStatus()
    public var completeProfileForm = CompleteProfileForm()
    public var completeProfileFlow = CompleteProfileFlow()
    public var completeProfileStatus = CompleteProfileStatus()
    public var uploadImageMediaFlow = UploadImageMediaFlow()
    public var uploadImageMediaStatus = UploadImageMediaStatus()
    public var restorePasswordFlow = RestorePasswordFlow()
    public var restorePasswordForm = RestorePasswordForm()
    public var restorePasswordStatus = RestorePasswordStatus()
    public var resendRestoreLinkFlow = ResendRestoreLinkFlow()
    public var resendRestoreLinkStatus = ResendRestoreLinkStatus()
    public var restoreTokenVerificationFlow = RestoreTokenVerificationFlow()
    public var restoreTokenVerificationStatus = RestoreTokenVerificationStatus()
    public var newPasswordFlow = NewPasswordFlow()
    public var newPasswordForm = NewPasswordForm()
    public var newPasswordStatus = NewPasswordStatus()
    public var deepLinkStatus = DeepLinkStatus()
    
    public mutating func reduce(_ action: Action) {
        signInForm.reduce(action)
        signInFlow.reduce(action)
        signInStatus.reduce(action)
        session.reduce(action)
        restoreSessionFlow.reduce(action)
        restoreSessionStatus.reduce(action)
        signUpForm.reduce(action)
        signUpFlow.reduce(action)
        signUpStatus.reduce(action)
        resendEmailFlow.reduce(action)
        resentEmailStatus.reduce(action)
        emailVerificationFlow.reduce(action)
        emailVerificationStatus.reduce(action)
        completeProfileForm.reduce(action)
        completeProfileFlow.reduce(action)
        completeProfileStatus.reduce(action)
        uploadImageMediaFlow.reduce(action)
        uploadImageMediaStatus.reduce(action)
        restorePasswordFlow.reduce(action)
        restorePasswordForm.reduce(action)
        restorePasswordStatus.reduce(action)
        resendRestoreLinkFlow.reduce(action)
        resendRestoreLinkStatus.reduce(action)
        restoreTokenVerificationFlow.reduce(action)
        restoreTokenVerificationStatus.reduce(action)
        newPasswordFlow.reduce(action)
        newPasswordForm.reduce(action)
        newPasswordStatus.reduce(action)
        deepLinkStatus.reduce(action)
    }
    
    public init() {}
}
