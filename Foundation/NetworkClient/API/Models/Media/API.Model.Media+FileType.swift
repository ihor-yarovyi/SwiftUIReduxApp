//
//  API.Model.Media+FileType.swift
//  NetworkClient
//
//  Created by Ihor Yarovyi on 11/13/21.
//

import Foundation

public extension NetworkClient.API.Model.Media {
    enum FileType: String, Codable {
        case image = "IMAGE"
        case video = "VIDEO"
    }
}
