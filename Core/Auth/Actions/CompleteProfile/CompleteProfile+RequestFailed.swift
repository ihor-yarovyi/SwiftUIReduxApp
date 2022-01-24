//
//  
//  CompleteProfile+RequestFailed.swift
//  Core
//
//  Created by Ihor Yarovyi on 11/12/21.
//
//

import Foundation

public extension Actions.CompleteProfile {
    struct RequestFailed: Action {
        let error: Error
        
        public init(_ error: Error) {
            self.error = error
        }
    }
}
