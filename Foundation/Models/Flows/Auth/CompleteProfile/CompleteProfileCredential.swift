//
//  CompleteProfileCredential.swift
//  Models
//
//  Created by Ihor Yarovyi on 10/14/21.
//

import Foundation

public extension Models.Auth {
    struct CompleteProfileCredential {
        public let firstName: FirstName
        public let lastName: LastName?
        public let phoneNumber: PhoneNumber?
        public let bio: BioInfo?
        
        public init(firstName: FirstName,
                    lastName: LastName?,
                    phoneNumber: PhoneNumber?,
                    bio: BioInfo?) {
            self.firstName = firstName
            self.lastName = lastName
            self.phoneNumber = phoneNumber
            self.bio = bio
        }
    }
}
