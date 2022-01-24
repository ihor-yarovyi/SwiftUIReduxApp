//
//  Avatar.swift
//  Models
//
//  Created by Ihor Yarovyi on 12/18/21.
//

import Foundation

public extension Models.Media {
    struct Avatar: Identifiable {
        public let id: Int64
        public let createdAt: Date
        public let updatedAt: Date
        public let authorId: Int64
        public let name: String
        public let status: FileStatus
        public let type: FileType
        public let link: String
    }
}
