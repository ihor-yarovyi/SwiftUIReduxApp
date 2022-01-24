//
//  SignIn.MainView+Progress.swift
//  SignIn
//
//  Created by Ihor Yarovyi on 8/15/21.
//

import SwiftUI
import SignUp

public extension SignIn.MainView {
    enum Progress {
        case none
        case active
        case failed(Error)
    }
}

// MARK: - Equatable
extension SignIn.MainView.Progress: Equatable {
    public static func == (lhs: SignIn.MainView.Progress, rhs: SignIn.MainView.Progress) -> Bool {
        if case .none = lhs, case .none = rhs {
            return true
        } else if case .active = lhs, case .active = rhs {
            return true
        } else if case let .failed(lError) = lhs, case let .failed(rError) = rhs {
            return lError.localizedDescription == rError.localizedDescription
        }
        return false
    }
}

// MARK: - Internal Properties
extension SignIn.MainView.Progress {
    var isPresented: Bool {
        guard case .failed = self else { return false }
        return true
    }
    
    var message: Text? {
        guard case let .failed(error) = self else { return nil }
        return Text(error.localizedDescription)
    }
}
