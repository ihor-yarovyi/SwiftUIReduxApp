//
//  SignIn+InvalidCredentials.swift
//  Core
//
//  Created by Ihor Yarovyi on 8/18/21.
//

import Foundation

public extension Actions.SignIn {
    struct InvalidCredentials: Action {
        public let error: Error
        
        public init(error: Error) {
            self.error = error
        }
    }
}
