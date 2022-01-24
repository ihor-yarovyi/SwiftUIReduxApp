//
//  Utils.Media+Thumbnail.swift
//  Utils
//
//  Created by Ihor Yarovyi on 11/13/21.
//

import UIKit

public extension Utils.Media {
    struct Thumbnail {
        public let data: Data
        public let size: CGSize
        
        public init(data: Data, size: CGSize) {
            self.data = data
            self.size = size
        }
    }
}
