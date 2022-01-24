//
//  FormData.swift
//  Models
//
//  Created by Ihor Yarovyi on 12/17/21.
//

import Foundation

public extension Models.Media {
    struct FormData {
        public let policy: String
        public let amzSignature: String
        public let amzDate: String
        public let contentType: String
        public let amzCredendial: String
        public let amzAlgorithm: String
        public let acl: String
        public let key: String
    }
}
