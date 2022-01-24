//
//  API.Provider+Auth.swift
//  NetworkClient
//
//  Created by Ihor Yarovyi on 8/23/21.
//

import Foundation

public extension NetworkClient.API.Provider {
    struct Auth: AuthProvider, RequestHelper {
        private init() {}
        
        public static let shared = Auth()
        
        public func signIn(login: String, password: String)
        -> NetworkClient.Request<NetworkClient.API.Response<NetworkClient.API.Model.SignInSession>> {
            let params = NetworkClient.Utils.Parameters {
                $0.login <- login
                $0.password <- password
            }
            return prepare(target: NetworkClient.API.Request.Auth.signIn(params: params.make()))
        }
        
        public func signUp(email: String, username: String, password: String)
        -> NetworkClient.Request<NetworkClient.API.Response<NetworkClient.API.Model.None>> {
            let params = NetworkClient.Utils.Parameters {
                $0.email <- email
                $0.username <- username
                $0.password <- password
            }
            return prepare(target: NetworkClient.API.Request.Auth.signUp(params: params.make()))
        }
        
        public func resendEmailVerifications(_ email: String)
        -> NetworkClient.Request<NetworkClient.API.Response<NetworkClient.API.Model.None>> {
            let params = NetworkClient.Utils.Parameters {
                $0.login <- email
            }
            return prepare(target: NetworkClient.API.Request.Auth.resendEmailVerifications(params: params.make()))
        }
        
        public func verifyToken(_ token: String)
        -> NetworkClient.Request<NetworkClient.API.Response<NetworkClient.API.Model.Session>> {
            let params = NetworkClient.Utils.Parameters {
                $0.token <- token
            }
            return prepare(target: NetworkClient.API.Request.Auth.verifyToken(params: params.make()))
        }
        
        public func completeProfile(firstName: String, lastName: String?, phone: String?, bio: String?)
        -> NetworkClient.Request<NetworkClient.API.Response<NetworkClient.API.Model.SignInSession>> {
            let params = NetworkClient.Utils.Parameters { params in
                params.firstName <- firstName
                lastName.map { params.lastName <- $0 }
                phone.map { params.phone <- $0 }
                bio.map { params.bio <- $0 }
            }
            return prepare(target: NetworkClient.API.Request.Auth.completeProfile(params: params.make()))
        }
        
        public func restorePassword(for email: String)
        -> NetworkClient.Request<NetworkClient.API.Response<NetworkClient.API.Model.None>> {
            let params = NetworkClient.Utils.Parameters {
                $0.email <- email
            }
            return prepare(target: NetworkClient.API.Request.Auth.restorePassword(params: params.make()))
        }
        
        public func verifyRestorePasswordToken(_ token: String)
        -> NetworkClient.Request<NetworkClient.API.Response<NetworkClient.API.Model.None>> {
            let params = NetworkClient.Utils.Parameters {
                $0.token <- token
            }
            return prepare(target: NetworkClient.API.Request.Auth.verifyRestorePasswordToken(params: params.make()))
        }
        
        public func passNewPassword(_ password: String, for token: String)
        -> NetworkClient.Request<NetworkClient.API.Response<NetworkClient.API.Model.None>> {
            let params = NetworkClient.Utils.Parameters {
                $0.token <- token
                $0.password <- password
            }
            return prepare(target: NetworkClient.API.Request.Auth.passNewPassword(params: params.make()))
        }
    }
}
