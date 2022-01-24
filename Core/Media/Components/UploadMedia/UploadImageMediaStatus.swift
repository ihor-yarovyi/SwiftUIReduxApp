//
//  
//  UploadImageMediaStatus.swift
//  Core
//
//  Created by Ihor Yarovyi on 12/18/21.
//
//

import Utils

public enum UploadImageMediaStatus {
    case none
    case inProgress(Utils.Media.Item)
    case failed(Error, Utils.Media.Item)
    case success(Utils.Media.Item)
    
    init() {
        self = .none
    }

    mutating func reduce(_ action: Action) {
        switch action {
        case let action as Actions.UploadMedia.Upload:
            self = .inProgress(action.item)
        case let action as Actions.UploadMedia.Failed:
            self = .failed(action.error, action.imageItem)
        case let action as Actions.UploadMedia.DidUploadImage:
            self = .success(action.imageItem)
        default:
            break
        }
    }
}
