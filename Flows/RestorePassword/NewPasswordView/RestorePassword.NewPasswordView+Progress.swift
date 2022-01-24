//
//  
//  RestorePassword.NewPasswordView+Progress.swift
//  RestorePassword
//
//  Created by Ihor Yarovyi on 1/3/22.
//
//

import SwiftUI

public extension RestorePassword.NewPasswordView {
    enum Progress {
        case none
        case active
        case success
        case failed(Error)
    }
}

// MARK: - Equatable
extension RestorePassword.NewPasswordView.Progress: Equatable {
    public static func == (lhs: RestorePassword.NewPasswordView.Progress, rhs: RestorePassword.NewPasswordView.Progress) -> Bool {
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
extension RestorePassword.NewPasswordView.Progress {
    var isPresented: Bool {
        guard case .failed = self else { return false }
        return true
    }
    
    var message: Text? {
        guard case let .failed(error) = self else { return nil }
        return Text(error.localizedDescription)
    }
}
