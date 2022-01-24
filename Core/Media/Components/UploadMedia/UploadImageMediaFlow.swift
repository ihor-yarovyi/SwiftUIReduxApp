//
//  
//  UploadImageMediaFlow.swift
//  Core
//
//  Created by Ihor Yarovyi on 11/13/21.
//
//

import Utils
import Models

public enum UploadImageMediaFlow {
    case none
    case downsample(Utils.Media.Item)
    case prepareS3(UUID, Utils.Media.Resized, Utils.Media.Item)
    case upload(UUID, Utils.Media.Resized, Models.Media.FileInfo, Utils.Media.Item)
    case updateFileStatus(UUID, Int64, Utils.Media.Item)
    case addPhoto(UUID, Int64, Utils.Media.Item)
    
    init() {
        self = .none
    }

    mutating func reduce(_ action: Action) {
        switch action {
        case let action as Actions.UploadMedia.Upload:
            self = .downsample(action.item)
        case let action as Actions.UploadMedia.Resized:
            self = .prepareS3(action.id, action.item, action.imageItem)
        case let action as Actions.UploadMedia.PreparedOnS3:
            self = .upload(UUID(), action.item, action.fileInfo, action.imageItem)
        case let action as Actions.UploadMedia.Uploaded:
            self = .updateFileStatus(UUID(), action.fileId, action.imageItem)
        case let action as Actions.UploadMedia.FileStatusUpdated:
            self = .addPhoto(UUID(), action.fileId, action.imageItem)
        case is Actions.UploadMedia.DidUploadImage,
            is Actions.UploadMedia.Failed:
            self = .none
        default:
            break
        }
    }
}
