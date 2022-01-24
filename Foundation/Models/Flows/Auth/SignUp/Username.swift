//
//  Username.swift
//  Models
//
//  Created by Ihor Yarovyi on 9/11/21.
//

import Utils
import Resources

public extension Models.Auth {
    struct Username {
        public let value: String
        
        private init(_ value: String) {
            self.value = value
        }
        
        public static func parse(value: String) -> Result<Username, Error> {
            if let error = validate(value) {
                return .failure(error)
            } else {
                return .success(.init(value))
            }
        }
    }
}

// MARK: - Validatable
extension Models.Auth.Username: Validatable {
    public static var rules: [ValidationRule] {
        [
            Utils.ValidationRules.Required(),
            Utils.ValidationRules.SpaceOnly(),
            Utils.ValidationRules.Range(1...30),
            Utils.ValidationRules.Match(
                regex: #"^[^@ ]{1,30}"#,
                message: Strings.Validation.shouldNotContain(name)
            )
        ]
    }
}
