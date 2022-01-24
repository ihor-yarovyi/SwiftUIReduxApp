//
//  
//  RestoreTokenVerification+DidVerify.swift
//  Core
//
//  Created by Ihor Yarovyi on 1/3/22.
//
//

import Foundation

public extension Actions.RestoreTokenVerification {
    struct DidVerify: Action {
        let token: String
        
        public init(_ token: String) {
            self.token = token
        }
    }
}
