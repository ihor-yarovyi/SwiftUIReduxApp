//
//  
//  UploadMedia+Resized.swift
//  Core
//
//  Created by Ihor Yarovyi on 11/13/21.
//
//

import Utils

public extension Actions.UploadMedia {
    struct Resized: Action {
        let id: UUID
        let item: Utils.Media.Resized
        let imageItem: Utils.Media.Item
        
        public init(id: UUID, item: Utils.Media.Resized, imageItem: Utils.Media.Item) {
            self.id = id
            self.item = item
            self.imageItem = imageItem
        }
    }
}
