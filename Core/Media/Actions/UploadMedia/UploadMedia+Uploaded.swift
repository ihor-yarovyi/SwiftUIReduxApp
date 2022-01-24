//
//  
//  UploadMedia+Uploaded.swift
//  Core
//
//  Created by Ihor Yarovyi on 12/18/21.
//
//

import Utils

public extension Actions.UploadMedia {
    struct Uploaded: Action {
        let fileId: Int64
        let imageItem: Utils.Media.Item
        
        public init(fileId: Int64, imageItem: Utils.Media.Item) {
            self.fileId = fileId
            self.imageItem = imageItem
        }
    }
}
