//
//  
//  SignUp+InvalidSignUpRequest.swift
//  Core
//
//  Created by Ihor Yarovyi on 9/11/21.
//
//

import Foundation

public extension Actions.SignUp {
    struct InvalidSignUpRequest: Action {
        public let error: Error
        
        public init(error: Error) {
            self.error = error
        }
    }
}
