//
//  FirstName.swift
//  Models
//
//  Created by Ihor Yarovyi on 10/14/21.
//

import Utils
import Resources

public extension Models.Auth {
    struct FirstName {
        public let value: String
        
        private init(_ value: String) {
            self.value = value
        }
        
        public static func parse(value: String) -> Result<FirstName, Error> {
            if let error = validate(value) {
                return .failure(error)
            } else {
                return .success(.init(value))
            }
        }
    }
}

// MARK: - Validatable
extension Models.Auth.FirstName: Validatable {
    public static var rules: [ValidationRule] {
        [
            Utils.ValidationRules.Required(),
            Utils.ValidationRules.SpaceOnly(),
            Utils.ValidationRules.Range(1...50),
            Utils.ValidationRules.Match(
                regex: #"[\p{L}\p{Nd}-_]"#,
                message: Strings.Validation.notValid(name)
            )
        ]
    }
}
