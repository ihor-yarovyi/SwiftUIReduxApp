//
//  
//  SignUp.MainView+Progress.swift
//  SignUp
//
//  Created by Ihor Yarovyi on 9/6/21.
//
//

import SwiftUI

public extension SignUp.MainView {
    enum Progress {
        case none
        case active
        case success
        case failed(Error)
    }
}

// MARK: - Equatable
extension SignUp.MainView.Progress: Equatable {
    public static func == (lhs: SignUp.MainView.Progress, rhs: SignUp.MainView.Progress) -> Bool {
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
extension SignUp.MainView.Progress {
    var isPresented: Bool {
        guard case .failed = self else { return false }
        return true
    }
    
    var message: Text? {
        guard case let .failed(error) = self else { return nil }
        return Text(error.localizedDescription)
    }
}
