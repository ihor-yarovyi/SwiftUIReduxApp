//
//  
//  UpdateRawEmail.swift
//  Core
//
//  Created by Ihor Yarovyi on 9/10/21.
//
//

import Foundation

public extension Actions.SignUp {
    struct UpdateRawEmail: Action {
        let email: String
        
        public init(email: String) {
            self.email = email
        }
    }
}
