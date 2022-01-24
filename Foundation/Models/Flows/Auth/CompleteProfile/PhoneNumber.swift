//
//  PhoneNumber.swift
//  Models
//
//  Created by Ihor Yarovyi on 10/14/21.
//

import Utils
import Resources

public extension Models.Auth {
    struct PhoneNumber {
        public let value: String
        
        private init(_ value: String) {
            self.value = value
        }
        
        public static func parse(value: String) -> Result<PhoneNumber, Error> {
            if let error = validate(value) {
                return .failure(error)
            } else {
                return .success(.init(value))
            }
        }
    }
}

// MARK: - Validatable
extension Models.Auth.PhoneNumber: Validatable {
    public static var rules: [ValidationRule] {
        [
            Utils.ValidationRules.Match(
                regex: #"^(\s*)?(\+)?([- _():=+]?\d[- _():=+]?){5,12}(\s*)?$"#,
                message: Strings.Validation.hasNotValidFormat(name)
            )
        ]
    }
}
