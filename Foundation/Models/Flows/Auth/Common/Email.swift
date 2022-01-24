//
//  Email.swift
//  Models
//
//  Created by Ihor Yarovyi on 8/16/21.
//

import Utils
import Resources

public extension Models {
    enum Auth {}
}

public extension Models.Auth {
    struct Email {
        public let value: String
        
        private init(_ value: String) {
            self.value = value
        }
        
        public static func parse(value: String) -> Result<Email, Error> {
            if let error = validate(value) {
                return .failure(error)
            } else {
                return .success(.init(value))
            }
        }
    }
}

// MARK: - Validatable
extension Models.Auth.Email: Validatable {    
    public static var rules: [ValidationRule] {
        [
            Utils.ValidationRules.Required(),
            Utils.ValidationRules.SpaceOnly(),
            Utils.ValidationRules.Range(6...129),
            Utils.ValidationRules.Match(
                regex: #"[\w\.+=-]{1,64}+@[\w\.-]+\.[\w]{2,}"#,
                message: Strings.Validation.notValid(name)
            )
        ]
    }
}
