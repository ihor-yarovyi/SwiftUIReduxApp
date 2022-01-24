//
//  
//  ResendEmailVerification+DidFailSend.swift
//  Core
//
//  Created by Ihor Yarovyi on 9/28/21.
//
//

import Foundation

public extension Actions.ResendEmailVerification {
    struct DidFailSend: Action {
        public let error: Error
        
        public init(error: Error) {
            self.error = error
        }
    }
}
