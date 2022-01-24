//
//  API.Media+S3Media.swift
//  NetworkClient
//
//  Created by Ihor Yarovyi on 11/13/21.
//

import NetworkLayer

extension NetworkClient.API.Request {
    enum S3Media: RequestConvertible {
        case uploadFile(url: URL?, multipartData: [NetworkClient.API.Model.Media.MultipartData], metaParams: [String: Any])
        
        public var path: String {
            switch self {
            case .uploadFile:
                return ""
            }
        }
        
        public var method: Network.Operator.Method {
            switch self {
            case .uploadFile:
                return .post
            }
        }
        
        public var task: Network.Operator.Task {
            switch self {
            case let .uploadFile(_, data, meta):
                return .uploadMultipart(
                    bodyParameters: meta,
                    multipartData: data.map {
                        .init(name: $0.name, fileData: $0.fileData, fileName: $0.fileName, mimeType: $0.mimeType)
                    },
                    urlParameters: [:]
                )
            }
        }
        
        public var authorizationStrategy: Network.AuthorizationStrategy? {
            switch self {
            case .uploadFile:
                return nil
            }
        }
        
        public var baseURL: URL? {
            switch self {
            case let .uploadFile(url, _, _):
                return url
            }
        }
    }
}
