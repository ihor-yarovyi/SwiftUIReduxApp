//
//  API.Model.Media+FormData.swift
//  NetworkClient
//
//  Created by Ihor Yarovyi on 11/13/21.
//

import Foundation

public extension NetworkClient.API.Model.Media {
    struct FormData: Codable {
        public let policy: String
        public let amzSignature: String
        public let amzDate: String
        public let contentType: String
        public let amzCredendial: String
        public let amzAlgorithm: String
        public let acl: String
        public let key: String
        
        public init(policy: String,
                    amzSignature: String,
                    amzDate: String,
                    contentType: String,
                    amzCredendial: String,
                    amzAlgorithm: String,
                    acl: String,
                    key: String) {
            self.policy = policy
            self.amzSignature = amzSignature
            self.amzDate = amzDate
            self.contentType = contentType
            self.amzCredendial = amzCredendial
            self.amzAlgorithm = amzAlgorithm
            self.acl = acl
            self.key = key
        }
    }
}

extension NetworkClient.API.Model.Media.FormData {
    enum CodingKeys: String, CodingKey {
        case policy = "Policy"
        case amzSignature = "X-Amz-Signature"
        case amzDate = "X-Amz-Date"
        case contentType = "Content-Type"
        case amzCredendial = "X-Amz-Credential"
        case amzAlgorithm = "X-Amz-Algorithm"
        case acl
        case key
    }
}
