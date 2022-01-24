//
//  API.Model.Media+PrepareFileParameters.swift
//  NetworkClient
//
//  Created by Ihor Yarovyi on 11/13/21.
//

import Foundation

public extension NetworkClient.API.Model.Media {
    struct PrepareFileParameters: Encodable {
        public let contentType: String
        public let type: String
        public let resizePrefixes: [String]
        
        public init(contentType: ContentType,
                    fileType: FileType,
                    resizePrefixes: [String]) {
            self.contentType = contentType.rawValue
            self.type = fileType.rawValue
            self.resizePrefixes = resizePrefixes
        }
    }
}
