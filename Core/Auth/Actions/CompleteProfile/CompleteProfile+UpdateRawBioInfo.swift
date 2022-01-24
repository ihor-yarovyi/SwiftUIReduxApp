//
//  
//  CompleteProfile+UpdateRawBioInfo.swift
//  Core
//
//  Created by Ihor Yarovyi on 10/14/21.
//
//

import Foundation

public extension Actions.CompleteProfile {
    struct UpdateRawBioInfo: Action {
        let bioInfo: String
        
        public init(bioInfo: String) {
            self.bioInfo = bioInfo
        }
    }
}
