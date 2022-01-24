//
//  
//  UploadMedia+Upload.swift
//  Core
//
//  Created by Ihor Yarovyi on 11/13/21.
//
//

import Utils

public extension Actions.UploadMedia {
    struct Upload: Action {
        let item: Utils.Media.Item
        
        public init(_ item: Utils.Media.Item) {
            self.item = item
        }
    }
}
