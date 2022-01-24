//
//  
//  DeepLink+DidReceive.swift
//  Core
//
//  Created by Ihor Yarovyi on 10/1/21.
//
//

import Utils

public extension Actions.DeepLink {
    struct DidReceive: Action {
        public let kind: Utils.DeepLink.Kind
        
        public init(kind: Utils.DeepLink.Kind) {
            self.kind = kind
        }
    }
}
