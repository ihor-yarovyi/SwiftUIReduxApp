//
//  
//  SignUp.CompleteProfile+Connector.swift
//  SignUp
//
//  Created by Ihor Yarovyi on 10/9/21.
//
//

import SwiftUI
import Redux
import Core

public extension SignUp.CompleteProfile {
    struct Connector: Redux.Connector {
        public init() {}

        public func map(graph: Graph) -> some View {
            SignUp.CompleteProfile(
                createAccountAction: .available(graph.completeProfile.createAccount),
                chooseFromCameraAction: .available(graph.completeProfile.takePhotoFromCamera),
                chooseFromGalleryAction: .available(graph.completeProfile.takePhotoFromGallery),
                screenProgress: graph.completeProfile.screenProgress,
                firstName: Binding(get: {
                    graph.completeProfile.firstName
                }, set: {
                    graph.completeProfile.firstName = $0
                }),
                lastName: Binding(get: {
                    graph.completeProfile.lastName
                }, set: {
                    graph.completeProfile.lastName = $0
                }),
                phoneNumber: Binding(get: {
                    graph.completeProfile.phoneNumber
                }, set: {
                    graph.completeProfile.phoneNumber = $0
                }),
                bio: Binding(get: {
                    graph.completeProfile.bioInfo
                }, set: {
                    graph.completeProfile.bioInfo = $0
                }),
                photoState: Binding(get: {
                    graph.completeProfile.photoState
                }, set: {
                    graph.completeProfile.photoState = $0
                })
            )
        }
    }
}

extension CompleteProfileNode {
    var screenProgress: SignUp.CompleteProfile.Progress {
        switch completeProfileProgress {
        case .none:
            return .none
        case .inProgress:
            return .active
        case .success:
            return .none
        case let .failed(error):
            return .failed(error)
        }
    }
}
