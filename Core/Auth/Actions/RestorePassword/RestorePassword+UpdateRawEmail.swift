//
//  
//  RestorePassword+UpdateRawEmail.swift
//  Core
//
//  Created by Ihor Yarovyi on 02.01.2022.
//
//

import Foundation

public extension Actions.RestorePassword {
    struct UpdateRawEmail: Action {
        let email: String
        
        public init(_ email: String) {
            self.email = email
        }
    }
}
