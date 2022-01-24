//
//  
//  CompleteProfileNode.swift
//  Core
//
//  Created by Ihor Yarovyi on 10/16/21.
//
//

import Models
import Utils

public extension Graph {
    var completeProfile: CompleteProfileNode {
        CompleteProfileNode(graph: self)
    }
}

public struct CompleteProfileNode {
    let graph: Graph

    public var firstName: String {
        get {
            graph.state.completeProfileForm.firstName
        }
        nonmutating set {
            graph.dispatch(Actions.CompleteProfile.UpdateRawFirstName(firstName: newValue))
        }
    }
    
    public var lastName: String {
        get {
            graph.state.completeProfileForm.lastName
        }
        nonmutating set {
            graph.dispatch(Actions.CompleteProfile.UpdateRawLastName(lastName: newValue))
        }
    }
    
    public var phoneNumber: String {
        get {
            graph.state.completeProfileForm.phoneNumber
        }
        nonmutating set {
            graph.dispatch(Actions.CompleteProfile.UpdateRawPhoneNumber(phoneNumber: newValue))
        }
    }
    
    public var completeProfileProgress: CompleteProfileStatus {
        graph.state.completeProfileStatus
    }
    
    public var bioInfo: String {
        get {
            graph.state.completeProfileForm.bioInfo
        }
        nonmutating set {
            graph.dispatch(Actions.CompleteProfile.UpdateRawBioInfo(bioInfo: newValue))
        }
    }
    
    public var photoState: Utils.PhotoGallery.TakePhotoState {
        get {
            graph.state.completeProfileForm.photoState
        }
        nonmutating set {
            graph.dispatch(Actions.CompleteProfile.UpdatePhotoState(state: newValue))
        }
    }

    public func createAccount() {
        graph.dispatch(Actions.CompleteProfile.CreateAccount())
    }
    
    public func takePhotoFromCamera() {
        graph.dispatch(Actions.CompleteProfile.RequestAccessToCamera())
    }
    
    public func takePhotoFromGallery() {
        graph.dispatch(Actions.CompleteProfile.RequestAccessToGallery())
    }
}
