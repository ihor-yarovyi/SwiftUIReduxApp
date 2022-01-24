//
//  
//  CompleteProfile+UpdateRawLastName.swift
//  Core
//
//  Created by Ihor Yarovyi on 10/14/21.
//
//

import Foundation

public extension Actions.CompleteProfile {
    struct UpdateRawLastName: Action {
        let lastName: String
        
        public init(lastName: String) {
            self.lastName = lastName
        }
    }
}
