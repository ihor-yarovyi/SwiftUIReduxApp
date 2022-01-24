//
//  
//  CompleteProfile+UpdateRawPhoneNumber.swift
//  Core
//
//  Created by Ihor Yarovyi on 10/14/21.
//
//

import Foundation

public extension Actions.CompleteProfile {
    struct UpdateRawPhoneNumber: Action {
        let phoneNumber: String
        
        public init(phoneNumber: String) {
            self.phoneNumber = phoneNumber
        }
    }
}
