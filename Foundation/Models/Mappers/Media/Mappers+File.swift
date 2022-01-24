//
//  Mappers+File.swift
//  Models
//
//  Created by Ihor Yarovyi on 12/17/21.
//

import NetworkClient

public extension Models.Mappers.Media {
    static func map(_ file: NetworkClient.API.Model.Media.File) -> Models.Media.File {
        .init(
            id: file.id,
            createdAt: file.createdAt.value,
            updatedAt: file.updatedAt.value,
            authorId: file.authorId,
            name: file.name,
            status: map(file.status),
            type: map(file.type),
            link: file.link,
            videoPreviewLink: file.videoPreviewLink
        )
    }
    
    static func map(_ status: NetworkClient.API.Model.Media.FileStatus) -> Models.Media.FileStatus {
        switch status {
        case .loaded:
            return .loaded
        case .pending:
            return .pending
        }
    }
    
    static func map(_ type: NetworkClient.API.Model.Media.FileType) -> Models.Media.FileType {
        switch type {
        case .image:
            return .image
        case .video:
            return .video
        }
    }
}
