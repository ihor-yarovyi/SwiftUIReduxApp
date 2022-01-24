//
//  
//  RestorePassword.MainView+Progress.swift
//  RestorePassword
//
//  Created by Ihor Yarovyi on 01.01.2022.
//
//

import SwiftUI

public extension RestorePassword.MainView {
    enum Progress {
        case none
        case active
        case success
        case failed(Error)
    }
}

// MARK: - Equatable
extension RestorePassword.MainView.Progress: Equatable {
    public static func == (lhs: RestorePassword.MainView.Progress, rhs: RestorePassword.MainView.Progress) -> Bool {
        if case .none = lhs, case .none = rhs {
            return true
        } else if case .active = lhs, case .active = rhs {
            return true
        } else if case .success = lhs, case .success = rhs {
            return true
        } else if case let .failed(lError) = lhs, case let .failed(rError) = rhs {
            return lError.localizedDescription == rError.localizedDescription
        }
        return false
    }
}

// MARK: - Internal Properties
extension RestorePassword.MainView.Progress {
    var isPresented: Bool {
        guard case .failed = self else { return false }
        return true
    }
    
    var message: Text? {
        guard case let .failed(error) = self else { return nil }
        return Text(error.localizedDescription)
    }
}
