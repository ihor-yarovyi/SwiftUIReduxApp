//
//  API.Model.Media+Meta.swift
//  NetworkClient
//
//  Created by Ihor Yarovyi on 11/13/21.
//

import Foundation

public extension NetworkClient.API.Model.Media {
    struct Meta: Codable {
        public let formData: FormData
        public let url: URL?
        
        public init(formData: NetworkClient.API.Model.Media.FormData, url: URL?) {
            self.formData = formData
            self.url = url
        }
    }
}
