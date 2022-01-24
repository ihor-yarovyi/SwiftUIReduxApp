//
//  API.Model.Media+FileInfo.swift
//  NetworkClient
//
//  Created by Ihor Yarovyi on 11/13/21.
//

import Foundation

public extension NetworkClient.API.Model.Media {
    struct FileInfo: Decodable {
        public let file: File
        public let meta: Meta
        public let metaForResize: [Meta]
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            file = try container.decode(File.self, forKey: .file)
            meta = try container.decode(Meta.self, forKey: .meta)
            metaForResize = try container.decodeIfPresent([Meta].self, forKey: .metaForResize) ?? []
        }
    }
}

extension NetworkClient.API.Model.Media.FileInfo {
    enum CodingKeys: String, CodingKey {
        case file
        case meta
        case metaForResize
    }
}
