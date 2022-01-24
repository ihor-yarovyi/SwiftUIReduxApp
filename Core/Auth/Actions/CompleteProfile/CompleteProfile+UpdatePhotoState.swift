//
//  
//  CompleteProfile+UpdatePhotoState.swift
//  Core
//
//  Created by Ihor Yarovyi on 11/3/21.
//
//

import Utils

public extension Actions.CompleteProfile {
    struct UpdatePhotoState: Action {
        let state: Utils.PhotoGallery.TakePhotoState
        
        public init(state: Utils.PhotoGallery.TakePhotoState) {
            self.state = state
        }
    }
}
