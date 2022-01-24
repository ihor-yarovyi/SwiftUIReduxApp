//
//  RequestProvider.swift
//  NetworkClient
//
//  Created by Ihor Yarovyi on 8/23/21.
//

import Foundation

protocol HasAuthProvider {
    static var auth: AuthProvider { get }
}

protocol HasMediaProvider {
    static var media: MediaProvider { get }
}

typealias RequestProvider = HasAuthProvider & HasMediaProvider
