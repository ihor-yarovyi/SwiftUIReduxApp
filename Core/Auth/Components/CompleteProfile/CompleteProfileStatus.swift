//
//  
//  CompleteProfileStatus.swift
//  Core
//
//  Created by Ihor Yarovyi on 10/14/21.
//
//

import Foundation

public enum CompleteProfileStatus {
    case none
    case inProgress
    case failed(Error)
    case success
    
    init() {
        self = .none
    }

    mutating func reduce(_ action: Action) {
        switch action {
        case let action as Actions.CompleteProfile.UpdatePhotoState:
            switch action.state {
            case .compress:
                self = .inProgress
            case .crop, .denied, .done, .failed, .none, .take:
                self = .none
            }
        case is Actions.CompleteProfile.CreateAccount:
            self = .inProgress
        case is Actions.CompleteProfile.Completed:
            self = .success
        case let action as Actions.CompleteProfile.InvalidCredential:
            self = .failed(action.error)
        case let action as Actions.CompleteProfile.RequestFailed:
            self = .failed(action.error)
        case let action as Actions.CompleteProfile.UploadFailed:
            self = .failed(action.error)
        default:
            break
        }
    }
}
