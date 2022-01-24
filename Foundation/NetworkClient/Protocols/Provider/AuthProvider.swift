//
//  AuthProvider.swift
//  NetworkClient
//
//  Created by Ihor Yarovyi on 8/23/21.
//

import Foundation

public protocol AuthProvider {
    func signIn(login: String, password: String)
    -> NetworkClient.Request<NetworkClient.API.Response<NetworkClient.API.Model.SignInSession>>
    
    func signUp(email: String, username: String, password: String)
    -> NetworkClient.Request<NetworkClient.API.Response<NetworkClient.API.Model.None>>
    func resendEmailVerifications(_ email: String) -> NetworkClient.Request<NetworkClient.API.Response<NetworkClient.API.Model.None>>
    func verifyToken(_ token: String) -> NetworkClient.Request<NetworkClient.API.Response<NetworkClient.API.Model.Session>>
    func completeProfile(firstName: String, lastName: String?, phone: String?, bio: String?)
    -> NetworkClient.Request<NetworkClient.API.Response<NetworkClient.API.Model.SignInSession>>
    
    func restorePassword(for email: String) -> NetworkClient.Request<NetworkClient.API.Response<NetworkClient.API.Model.None>>
    func verifyRestorePasswordToken(_ token: String) -> NetworkClient.Request<NetworkClient.API.Response<NetworkClient.API.Model.None>>
    func passNewPassword(_ password: String, for token: String)
    -> NetworkClient.Request<NetworkClient.API.Response<NetworkClient.API.Model.None>>
}
