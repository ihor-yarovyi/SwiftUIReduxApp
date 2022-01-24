//
//  
//  CompleteProfileForm.swift
//  Core
//
//  Created by Ihor Yarovyi on 10/14/21.
//
//

import Models
import Utils

public struct CompleteProfileForm {
    public var firstName: String = ""
    public var lastName: String = ""
    public var phoneNumber: String = ""
    public var bioInfo: String = ""
    public var credential: Models.Auth.CompleteProfileCredential?
    public var imageItem: Utils.Media.Item?
    public var photoState: Utils.PhotoGallery.TakePhotoState = .none

    // swiftlint:disable:next cyclomatic_complexity
    mutating func reduce(_ action: Action) {
        switch action {
        case let action as Actions.CompleteProfile.UpdateRawFirstName:
            firstName = action.firstName
        case let action as Actions.CompleteProfile.UpdateRawLastName:
            lastName = action.lastName
        case let action as Actions.CompleteProfile.UpdateRawPhoneNumber:
            phoneNumber = action.phoneNumber
        case let action as Actions.CompleteProfile.UpdateRawBioInfo:
            bioInfo = action.bioInfo
        case let action as Actions.CompleteProfile.UpdatePhotoState:
            photoState = action.state
        case let action as Actions.CompleteProfile.UpdateCredential:
            credential = action.credential
        case let action as Actions.CompleteProfile.UploadImageItem:
            imageItem = action.imageItem
        case let action as Actions.CompleteProfile.UploadFailed:
            guard imageItem?.id == action.item.id else { return }
            imageItem = nil
        case is Actions.CompleteProfile.Completed:
            self = Self()
        default:
            break
        }
    }
}
