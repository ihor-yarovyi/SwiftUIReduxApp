//
//  API.Model.Media+File.swift
//  NetworkClient
//
//  Created by Ihor Yarovyi on 11/13/21.
//

import Foundation

public extension NetworkClient.API.Model.Media {
    struct File: Decodable {
        public let id: Int64
        public let createdAt: NetworkClient.Utils.ISO8601DateCoder
        public let updatedAt: NetworkClient.Utils.ISO8601DateCoder
        public let authorId: Int64
        public let name: String
        public let status: FileStatus
        public let type: FileType
        public let link: String
        public let videoPreviewLink: String?
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(Int64.self, forKey: .id)
            authorId = try container.decode(Int64.self, forKey: .authorId)
            name = try container.decode(String.self, forKey: .name)
            status = try container.decodeIfPresent(FileStatus.self, forKey: .status) ?? .pending
            createdAt = try container.decodeIfPresent(NetworkClient.Utils.ISO8601DateCoder.self, forKey: .createdAt) ?? .init(date: Date())
            updatedAt = try container.decodeIfPresent(NetworkClient.Utils.ISO8601DateCoder.self, forKey: .updatedAt) ?? .init(date: Date())
            type = try container.decodeIfPresent(FileType.self, forKey: .type) ?? .image
            link = try container.decode(String.self, forKey: .link)
            videoPreviewLink = try? container.decodeIfPresent(String.self, forKey: .videoPreviewLink)
        }
    }
}

extension NetworkClient.API.Model.Media.File {
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt
        case updatedAt
        case authorId
        case name
        case status
        case type
        case link
        case videoPreviewLink
    }
}
