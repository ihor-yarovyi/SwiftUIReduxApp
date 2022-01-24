//
//  
//  UploadMedia+PreparedOnS3.swift
//  Core
//
//  Created by Ihor Yarovyi on 12/17/21.
//
//

import Models
import Utils

public extension Actions.UploadMedia {
    struct PreparedOnS3: Action {
        let fileInfo: Models.Media.FileInfo
        let item: Utils.Media.Resized
        let imageItem: Utils.Media.Item
        
        public init(fileInfo: Models.Media.FileInfo, item: Utils.Media.Resized, imageItem: Utils.Media.Item) {
            self.fileInfo = fileInfo
            self.item = item
            self.imageItem = imageItem
        }
    }
}
