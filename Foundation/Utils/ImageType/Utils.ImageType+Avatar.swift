//
//  Utils.ImageType+Avatar.swift
//  Utils
//
//  Created by Ihor Yarovyi on 11/12/21.
//

import UIKit

public extension Utils.ImageType {
    struct Avatar: ImageType {
        public var original: CGSize { .init(width: 300, height: 300) }
        public var small: CGSize { .init(width: 32, height: 32) }
        public var medium: CGSize { .init(width: 100, height: 100) }
        
        public init() {}
    }
}
