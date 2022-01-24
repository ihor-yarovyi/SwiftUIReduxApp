//
//  ConfirmPassword.swift
//  Models
//
//  Created by Ihor Yarovyi on 9/11/21.
//

import Utils
import Resources

public extension Models.Auth {
    struct ConfirmPassword {
        public let value: String
        private static var passwordValue: String = ""
        
        private init(_ value: String) {
            self.value = value
        }
        
        public static func parse(value: String, with password: Password) -> Result<ConfirmPassword, Error> {
            passwordValue = password.value
            if let error = validate(value) {
                return .failure(error)
            } else {
                return .success(.init(value))
            }
        }
    }
}

// MARK: - Validatable
extension Models.Auth.ConfirmPassword: Validatable {
    public static var name: String {
        Strings.SignUp.Validation.groupName
    }
    
    public static var rules: [ValidationRule] {
        [
            Utils.ValidationRules.Required(),
            Utils.ValidationRules.EqualTo(otherValue: passwordValue)
        ]
    }
}
