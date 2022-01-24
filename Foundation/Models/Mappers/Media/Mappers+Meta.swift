//
//  Mappers+Meta.swift
//  Models
//
//  Created by Ihor Yarovyi on 12/17/21.
//

import NetworkClient

public extension Models.Mappers.Media {
    static func map(_ meta: NetworkClient.API.Model.Media.Meta) -> Models.Media.Meta {
        .init(formData: map(meta.formData), url: meta.url)
    }
    
    static func map(_ meta: Models.Media.Meta) -> NetworkClient.API.Model.Media.Meta {
        .init(formData: map(meta.formData), url: meta.url)
    }
    
    static func map(_ formData: NetworkClient.API.Model.Media.FormData) -> Models.Media.FormData {
        .init(
            policy: formData.policy,
            amzSignature: formData.amzSignature,
            amzDate: formData.amzDate,
            contentType: formData.contentType,
            amzCredendial: formData.amzCredendial,
            amzAlgorithm: formData.amzAlgorithm,
            acl: formData.acl,
            key: formData.key
        )
    }
    
    static func map(_ formData: Models.Media.FormData) -> NetworkClient.API.Model.Media.FormData {
        .init(
            policy: formData.policy,
            amzSignature: formData.amzSignature,
            amzDate: formData.amzDate,
            contentType: formData.contentType,
            amzCredendial: formData.amzCredendial,
            amzAlgorithm: formData.amzAlgorithm,
            acl: formData.acl,
            key: formData.key
        )
    }
}
