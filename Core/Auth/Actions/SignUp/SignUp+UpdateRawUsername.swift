//
//  
//  UpdateRawUsername.swift
//  Core
//
//  Created by Ihor Yarovyi on 9/10/21.
//
//

import Foundation

public extension Actions.SignUp {
    struct UpdateRawUsername: Action {
        let username: String
        
        public init(username: String) {
            self.username = username
        }
    }
}
