//
//  
//  DeepLinkStatus.swift
//  Core
//
//  Created by Ihor Yarovyi on 1/4/22.
//
//

import Foundation

public enum DeepLinkStatus {
    case none
    case inProgress
    
    init() {
        self = .none
    }

    mutating func reduce(_ action: Action) {
        switch action {
        case is Actions.DeepLink.Start:
            self = .inProgress
        case is Actions.SignIn.DidSignIn:
            guard case .inProgress = self else { return }
            self = .none
        default:
            break
        }
    }
}
