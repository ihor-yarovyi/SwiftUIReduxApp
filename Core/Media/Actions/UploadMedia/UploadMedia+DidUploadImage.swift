//
//  
//  UploadMedia+DidUploadImage.swift
//  Core
//
//  Created by Ihor Yarovyi on 12/18/21.
//
//

import Models
import Utils

public extension Actions.UploadMedia {
    struct DidUploadImage: Action {
        let avatar: Models.Media.Avatar
        let imageItem: Utils.Media.Item
        
        public init(_ avatar: Models.Media.Avatar, imageItem: Utils.Media.Item) {
            self.avatar = avatar
            self.imageItem = imageItem
        }
    }
}
