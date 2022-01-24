//
//  
//  CompleteProfile+UploadImageItem.swift
//  Core
//
//  Created by Ihor Yarovyi on 12/18/21.
//
//

import Utils

public extension Actions.CompleteProfile {
    struct UploadImageItem: Action {
        let imageItem: Utils.Media.Item
        
        public init(_ imageItem: Utils.Media.Item) {
            self.imageItem = imageItem
        }
    }
}
