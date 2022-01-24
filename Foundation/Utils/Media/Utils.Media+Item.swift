//
//  Utils.Media+Item.swift
//  Utils
//
//  Created by Ihor Yarovyi on 11/13/21.
//

import UIKit

public extension Utils.Media {
    struct Item {
        public let id: UUID
        public let image: UIImage
        public let type: ImageType
        
        public init(id: UUID, image: UIImage, type: ImageType) {
            self.id = id
            self.image = image
            self.type = type
        }
    }
}
