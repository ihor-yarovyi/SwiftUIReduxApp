//
//  Mappers+Avatar.swift
//  Models
//
//  Created by Ihor Yarovyi on 12/18/21.
//

import NetworkClient

public extension Models.Mappers.Media {
    static func map(_ avatar: NetworkClient.API.Model.Media.Avatar) -> Models.Media.Avatar {
        .init(
            id: avatar.id,
            createdAt: avatar.createdAt.value,
            updatedAt: avatar.updatedAt.value,
            authorId: avatar.authorId,
            name: avatar.name,
            status: map(avatar.status),
            type: map(avatar.type),
            link: avatar.link
        )
    }
}
