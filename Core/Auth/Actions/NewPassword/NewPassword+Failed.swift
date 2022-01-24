//
//  
//  NewPassword+Failed.swift
//  Core
//
//  Created by Ihor Yarovyi on 1/4/22.
//
//

import Foundation

public extension Actions.NewPassword {
    struct Failed: Action {
        let error: Error
        
        public init(_ error: Error) {
            self.error = error
        }
    }
}
