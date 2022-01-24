//
//  Utils.Media+Resized.swift
//  Utils
//
//  Created by Ihor Yarovyi on 11/13/21.
//

import Foundation

public extension Utils.Media {
    struct Resized {
        public let original: Data
        public let thumbnails: [Thumbnail]
        
        public init(original: Data, thumbnails: [Thumbnail]) {
            self.original = original
            self.thumbnails = thumbnails
        }
    }
}
