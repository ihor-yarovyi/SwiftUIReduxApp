//
//  
//  RestorePassword+Failed.swift
//  Core
//
//  Created by Ihor Yarovyi on 02.01.2022.
//
//

import Foundation

public extension Actions.RestorePassword {
    struct Failed: Action {
        let error: Error
        
        public init(_ error: Error) {
            self.error = error
        }
    }
}
