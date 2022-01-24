//
//  API.Request+Media.swift
//  NetworkClient
//
//  Created by Ihor Yarovyi on 11/13/21.
//

import NetworkLayer

public extension NetworkClient.API.Request {
    enum Media: RequestConvertible {
        case prepareFile(params: Encodable)
        case updateFilesStatus(params: Encodable)
        case addImage(params: [String: Any])
        
        public var path: String {
            switch self {
            case .prepareFile, .updateFilesStatus:
                return "/files"
            case .addImage:
                return "/users/avatar"
            }
        }
        
        public var method: Network.Operator.Method {
            switch self {
            case .prepareFile, .addImage:
                return .post
            case .updateFilesStatus:
                return .patch
            }
        }
        
        public var task: Network.Operator.Task {
            switch self {
            case let .prepareFile(params), let .updateFilesStatus(params):
                return .requestJSONEncodable(params, urlParameters: [:])
            case let .addImage(params):
                return .requestCompositeParameters(bodyParameters: params, bodyEncoding: .json, urlParameters: [:])
            }
        }
        
        public var authorizationStrategy: Network.AuthorizationStrategy? {
            switch self {
            case .prepareFile, .updateFilesStatus, .addImage:
                return .token
            }
        }
    }
}
