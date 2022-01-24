//
//  
//  ResendRestoreLink+DidFail.swift
//  Core
//
//  Created by Ihor Yarovyi on 1/3/22.
//
//

import Foundation

public extension Actions.ResendRestoreLink {
    struct DidFail: Action {
        let error: Error
        
        public init(_ error: Error) {
            self.error = error
        }
    }
}
