//
//  FileInfo.swift
//  Models
//
//  Created by Ihor Yarovyi on 12/17/21.
//

import Foundation

public extension Models.Media {
    struct FileInfo {
        public let file: File
        public let meta: Meta
        public let metaForResize: [Meta]
        
        public init(file: File, meta: Meta, metaForResize: [Meta]) {
            self.file = file
            self.meta = meta
            self.metaForResize = metaForResize
        }
    }
}
