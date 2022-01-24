//
//  ImageType.swift
//  Utils
//
//  Created by Ihor Yarovyi on 11/12/21.
//

import UIKit

public protocol ImageType {
    var original: CGSize { get }
    var small: CGSize { get }
    var medium: CGSize { get }
}
