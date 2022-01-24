//
//  
//  CompleteProfileFlow.swift
//  Core
//
//  Created by Ihor Yarovyi on 10/14/21.
//
//

import Foundation
import Utils

public enum CompleteProfileFlow {
    case none
    case requestAccessToCamera
    case requestAccessToGallery
    case compressPhoto
    case validation
    case completeProfile(UUID)
    case uploadAvatar(UUID)
    case performUpload
    
    init() {
        self = .none
    }

    mutating func reduce(_ action: Action) {
        switch action {
        case is Actions.CompleteProfile.RequestAccessToCamera:
            self = .requestAccessToCamera
        case is Actions.CompleteProfile.RequestAccessToGallery:
            self = .requestAccessToGallery
        case let action as Actions.CompleteProfile.UpdatePhotoState:
            self = takeState(from: action.state)
        case is Actions.CompleteProfile.CreateAccount:
            self = .validation
        case is Actions.CompleteProfile.UpdateCredential:
            self = .completeProfile(UUID())
        case is Actions.SignIn.DidSignIn:
            self = .uploadAvatar(UUID())
        case is Actions.CompleteProfile.UploadImageItem:
            self = .performUpload
        case is Actions.CompleteProfile.Completed,
            is Actions.CompleteProfile.UpdateCredential,
            is Actions.CompleteProfile.InvalidCredential,
            is Actions.CompleteProfile.RequestFailed,
            is Actions.CompleteProfile.UploadFailed,
            is Actions.UploadMedia.Upload:
            self = .none
        default:
            break
        }
    }
    
    private func takeState(from photoState: Utils.PhotoGallery.TakePhotoState) -> CompleteProfileFlow {
        switch photoState {
        case .compress:
            return .compressPhoto
        case .denied, .take, .failed, .crop, .done, .none:
            return .none
        }
    }
}
