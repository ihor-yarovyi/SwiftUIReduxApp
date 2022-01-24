//
//  
//  DeepLinkNode.swift
//  Core
//
//  Created by Ihor Yarovyi on 1/4/22.
//
//

import Models

public extension Graph {
    var deepLink: DeepLinkNode {
        DeepLinkNode(graph: self)
    }
}

public struct DeepLinkNode {
    let graph: Graph

    public var isActive: Bool {
        graph.state.deepLinkStatus == .inProgress
    }
}
