//
//  API.Request+Auth.swift
//  NetworkClient
//
//  Created by Ihor Yarovyi on 8/23/21.
//

import NetworkLayer

public extension NetworkClient.API.Request {
    enum Auth: RequestConvertible {
        case signIn(params: [String: Any])
        case signUp(params: [String: Any])
        case resendEmailVerifications(params: [String: Any])
        case verifyToken(params: [String: Any])
        case completeProfile(params: [String: Any])
        case restorePassword(params: [String: Any])
        case verifyRestorePasswordToken(params: [String: Any])
        case passNewPassword(params: [String: Any])
        
        public var path: String {
            switch self {
            case .signIn:
                return "/sessions"
            case .signUp:
                return "/users"
            case .resendEmailVerifications:
                return "/verifications"
            case .verifyToken:
                return "/verifications"
            case .completeProfile:
                return "/users/profile"
            case .restorePassword, .passNewPassword:
                return "/verifications/password"
            case .verifyRestorePasswordToken:
                return "/verifications/token"
            }
        }
        
        public var method: Network.Operator.Method {
            switch self {
            case .signIn, .signUp, .resendEmailVerifications, .completeProfile, .restorePassword:
                return .post
            case .verifyToken, .verifyRestorePasswordToken, .passNewPassword:
                return .put
            }
        }
        
        public var task: Network.Operator.Task {
            switch self {
            case let .signIn(params), let .signUp(params), let .resendEmailVerifications(params),
                let .verifyToken(params), let .completeProfile(params), let .restorePassword(params),
                let .verifyRestorePasswordToken(params), let .passNewPassword(params):
                return .requestCompositeParameters(bodyParameters: params, bodyEncoding: .json, urlParameters: [:])
            }
        }
        
        public var authorizationStrategy: Network.AuthorizationStrategy? {
            switch self {
            case .signIn, .signUp, .resendEmailVerifications, .verifyToken, .restorePassword,
                    .verifyRestorePasswordToken, .passNewPassword:
                return nil
            case .completeProfile:
                return .token
            }
        }
    }
}
