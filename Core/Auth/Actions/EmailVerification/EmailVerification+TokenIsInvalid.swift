//
//  
//  EmailVerification+TokenIsInvalid.swift
//  Core
//
//  Created by Ihor Yarovyi on 10/3/21.
//
//

import Foundation

public extension Actions.EmailVerification {
    struct TokenIsInvalid: Action {
        public let error: Error
        
        public init(error: Error) {
            self.error = error
        }
    }
}
