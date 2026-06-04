//
//  Validator.swift
//  UnitTesting
//
//  Created by Sannidhya Roy on 04/06/26.
//

import Foundation

enum ValidationError: Error, Equatable {
    case emptyName
    case invalidEmail
    case underage
}

func validateUserInputs(name: String, email: String, age: Int) -> String? {
    if name.isEmpty { return "Error: name cannot be empty" }
    if !email.contains("@") { return "Error: invalid email" }
    if age < 18 { return "Error: You must be 18 or older" }
    return nil
}

func divide(_ a: Double, by b: Double) throws -> Double {
    guard b != 0 else { throw ValidationError.emptyName }
    return a / b
}
