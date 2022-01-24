//
//  
//  NewPassword+UpdateRawPassword.swift
//  Core
//
//  Created by Ihor Yarovyi on 1/4/22.
//
//

import Foundation

public extension Actions.NewPassword {
    struct UpdateRawPassword: Action {
        let rawPassword: String
        
        public init(_ value: String) {
            rawPassword = value
        }
    }
}
