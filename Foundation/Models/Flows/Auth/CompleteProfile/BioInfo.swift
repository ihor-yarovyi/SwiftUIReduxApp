//
//  BioInfo.swift
//  Models
//
//  Created by Ihor Yarovyi on 10/14/21.
//

import Utils
import Resources

public extension Models.Auth {
    struct BioInfo {
        public let value: String
        
        private init(_ value: String) {
            self.value = value
        }
        
        public static func parse(value: String) -> Result<BioInfo, Error> {
            if let error = validate(value) {
                return .failure(error)
            } else {
                return .success(.init(value))
            }
        }
    }
}

// MARK: - Validatable
extension Models.Auth.BioInfo: Validatable {
    public static var rules: [ValidationRule] {
        [
            Utils.ValidationRules.SpaceOnly(),
            Utils.ValidationRules.Match(
                regex: "[A-z0-9 ]{1,300}",
                message: Strings.Validation.mustBe(name, 1, 300)
            )
        ]
    }
}
