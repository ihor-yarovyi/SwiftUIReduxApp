//
//  SignIn+BadSignInRequest.swift
//  Core
//
//  Created by Ihor Yarovyi on 8/25/21.
//

import Foundation

public extension Actions.SignIn {
    struct BadSignInRequest: Action {
        public let error: Error
        
        public init(error: Error) {
            self.error = error
        }
    }
}
