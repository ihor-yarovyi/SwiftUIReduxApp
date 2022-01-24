//
//  API.Model.Media+FileStatus.swift
//  NetworkClient
//
//  Created by Ihor Yarovyi on 11/13/21.
//

import Foundation

public extension NetworkClient.API.Model.Media {
    enum FileStatus: String, Decodable {
        case pending = "PENDING"
        case loaded = "LOADED"
    }
}
