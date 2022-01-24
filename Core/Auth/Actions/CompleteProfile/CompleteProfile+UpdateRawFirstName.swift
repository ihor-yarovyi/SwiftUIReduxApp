//
//  
//  CompleteProfile+UpdateRawFirstName.swift
//  Core
//
//  Created by Ihor Yarovyi on 10/14/21.
//
//

import Foundation

public extension Actions.CompleteProfile {
    struct UpdateRawFirstName: Action {
        let firstName: String
        
        public init(firstName: String) {
            self.firstName = firstName
        }
    }
}
