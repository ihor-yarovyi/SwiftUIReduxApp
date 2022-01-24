//
//  
//  NewPassword+UpdateRawConfirmPassword.swift
//  Core
//
//  Created by Ihor Yarovyi on 1/4/22.
//
//

import Foundation

public extension Actions.NewPassword {
    struct UpdateRawConfirmPassword: Action {
        let rawConfirmPassword: String
        
        public init(_ value: String) {
            rawConfirmPassword = value
        }
    }
}
