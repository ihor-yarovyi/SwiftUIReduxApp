//
//  API.Model.Media+Avatar.swift
//  NetworkClient
//
//  Created by Ihor Yarovyi on 12/18/21.
//

import Foundation

public extension NetworkClient.API.Model.Media {
    struct Avatar: Decodable, Identifiable {
        public let id: Int64
        public let createdAt: NetworkClient.Utils.ISO8601DateCoder
        public let updatedAt: NetworkClient.Utils.ISO8601DateCoder
        public let authorId: Int64
        public let name: String
        public let status: FileStatus
        public let type: FileType
        public let link: String
    }
}
