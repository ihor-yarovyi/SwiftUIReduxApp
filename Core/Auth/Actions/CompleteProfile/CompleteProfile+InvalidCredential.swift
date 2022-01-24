//
//  
//  CompleteProfile+InvalidCredential.swift
//  Core
//
//  Created by Ihor Yarovyi on 11/3/21.
//
//

import Foundation

public extension Actions.CompleteProfile {
    struct InvalidCredential: Action {
        let error: Error
        
        public init(error: Error) {
            self.error = error
        }
    }
}
