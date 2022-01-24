//
//  SessionNode.swift
//  Core
//
//  Created by Ihor Yarovyi on 8/28/21.
//

import Foundation

public extension Graph {
    var session: SessionNode {
        SessionNode(graph: self)
    }
}

public struct SessionNode {
    let graph: Graph
    
    public func signOut() {
        graph.dispatch(Actions.Session.SignOut())
    }
    
    public var isActive: Bool {
        graph.state.session.session != nil && graph.state.session.userSaved
    }
    
    public var isRestoring: Bool {
        graph.state.restoreSessionStatus == .inProgress
    }
    
    public var hasSessionResult: Bool {
        graph.state.restoreSessionStatus == .success || graph.state.restoreSessionStatus == .failed
    }
}
