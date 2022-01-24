//
//  
//  UploadMedia+Failed.swift
//  Core
//
//  Created by Ihor Yarovyi on 12/17/21.
//
//

import Utils

public extension Actions.UploadMedia {
    struct Failed: Action {
        let error: Error
        let imageItem: Utils.Media.Item
        
        public init(_ error: Error, imageItem: Utils.Media.Item) {
            self.error = error
            self.imageItem = imageItem
        }
    }
}
