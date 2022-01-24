//
//  API.Provider+Media.swift
//  NetworkClient
//
//  Created by Ihor Yarovyi on 11/13/21.
//

import Foundation

public extension NetworkClient.API.Provider {
    struct Media: MediaProvider, RequestHelper {
        private init() {}
        
        public static let shared = Media()
        
        public func prepareS3Files(with parameters: [NetworkClient.API.Model.Media.PrepareFileParameters])
        -> NetworkClient.Request<NetworkClient.API.Response<[NetworkClient.API.Model.Media.FileInfo]>> {
            prepare(target: NetworkClient.API.Request.Media.prepareFile(params: parameters))
        }
        
        public func upload(data: Data, with meta: NetworkClient.API.Model.Media.Meta, type: NetworkClient.API.Model.Media.FileType)
        -> NetworkClient.Request<NetworkClient.API.Response<NetworkClient.API.Model.None>> {
            prepare(target: NetworkClient.API.Request.S3Media.uploadFile(
                url: meta.url,
                multipartData: [.init(name: "file", fileData: data, fileName: "file", mimeType: type.rawValue)],
                metaParams: meta.formData.asDictionary
            ))
        }
        
        public func updateFileStatus(fileId: Int64) -> NetworkClient.Request<NetworkClient.API.Response<NetworkClient.API.Model.None>> {
            prepare(target: NetworkClient.API.Request.Media.updateFilesStatus(params: [["fileId": fileId]]))
        }
        
        public func addPhoto(fileId: Int64) -> NetworkClient.Request<NetworkClient.API.Response<NetworkClient.API.Model.Media.Avatar>> {
            let params = NetworkClient.Utils.Parameters {
                $0.fileId <- fileId
            }
            return prepare(target: NetworkClient.API.Request.Media.addImage(params: params.make()))
        }
    }
}
