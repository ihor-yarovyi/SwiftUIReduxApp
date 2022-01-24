//
//  MediaProvider.swift
//  NetworkClient
//
//  Created by Ihor Yarovyi on 11/13/21.
//

import Foundation

public protocol MediaProvider {
    func prepareS3Files(with parameters: [NetworkClient.API.Model.Media.PrepareFileParameters])
    -> NetworkClient.Request<NetworkClient.API.Response<[NetworkClient.API.Model.Media.FileInfo]>>
    
    func upload(data: Data, with meta: NetworkClient.API.Model.Media.Meta, type: NetworkClient.API.Model.Media.FileType)
    -> NetworkClient.Request<NetworkClient.API.Response<NetworkClient.API.Model.None>>
    
    func updateFileStatus(fileId: Int64) -> NetworkClient.Request<NetworkClient.API.Response<NetworkClient.API.Model.None>>
    func addPhoto(fileId: Int64) -> NetworkClient.Request<NetworkClient.API.Response<NetworkClient.API.Model.Media.Avatar>>
}
