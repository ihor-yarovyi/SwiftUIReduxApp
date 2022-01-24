//
//  API.Model.Media+MultipartData.swift
//  NetworkClient
//
//  Created by Ihor Yarovyi on 11/19/21.
//

import Foundation

extension NetworkClient.API.Model.Media {
    struct MultipartData {
        let name: String
        let fileData: Data
        let fileName: String
        let mimeType: String
        
        init(name: String = UUID().uuidString, fileData: Data, fileName: String, mimeType: String) {
            self.name = name
            self.fileData = fileData
            self.fileName = fileName
            self.mimeType = mimeType
        }
    }
}
