//
//  
//  CompleteProfile+UploadFailed.swift
//  Core
//
//  Created by Ihor Yarovyi on 31.12.2021.
//
//

import Utils

public extension Actions.CompleteProfile {
    struct UploadFailed: Action {
        let error: Error
        let item: Utils.Media.Item
        
        public init(_ error: Error, item: Utils.Media.Item) {
            self.error = error
            self.item = item
        }
    }
}
