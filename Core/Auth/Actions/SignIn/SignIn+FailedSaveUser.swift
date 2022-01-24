//
//  SignIn+FailedSaveUser.swift
//  Core
//
//  Created by Ihor Yarovyi on 8/28/21.
//

import Foundation

public extension Actions.SignIn {
    struct FailedSaveUser: Action {
        public let error: Error
        
        public init(error: Error) {
            self.error = error
        }
    }
}
