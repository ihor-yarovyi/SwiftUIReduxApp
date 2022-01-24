//
//  Password.swift
//  Models
//
//  Created by Ihor Yarovyi on 8/17/21.
//

import Utils
import Resources

public extension Models.Auth {
    struct Password {
        public let value: String
        
        private init(_ value: String) {
            self.value = value
        }
        
        public static func parse(value: String) -> Result<Password, Error> {
            if let error = validate(value) {
                return .failure(error)
            } else {
                return .success(.init(value))
            }
        }
    }
}

// MARK: - Validatable
extension Models.Auth.Password: Validatable {    
    public static var rules: [ValidationRule] {
        [
            Utils.ValidationRules.Required(),
            Utils.ValidationRules.SpaceOnly(),
            Utils.ValidationRules.Range(8...50),
            Utils.ValidationRules.ContainSpace(),
            Utils.ValidationRules.Match(
                regex: ".{8,50}",
                message: Strings.Validation.shouldContain(name)
            )
        ]
    }
}
