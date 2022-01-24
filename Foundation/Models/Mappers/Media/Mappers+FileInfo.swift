//
//  Mappers+FileInfo.swift
//  Models
//
//  Created by Ihor Yarovyi on 12/17/21.
//

import NetworkClient

public extension Models.Mappers {
    enum Media {}
}

public extension Models.Mappers.Media {
    static func map(_ fileInfo: NetworkClient.API.Model.Media.FileInfo) -> Models.Media.FileInfo {
        .init(
            file: map(fileInfo.file),
            meta: map(fileInfo.meta),
            metaForResize: fileInfo.metaForResize.map { map($0) }
        )
    }
}
