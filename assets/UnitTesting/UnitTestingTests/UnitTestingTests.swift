//
//  UnitTestingTests.swift
//  UnitTestingTests
//
//  Created by Sannidhya Roy on 04/06/26.
//

import Testing
@testable import UnitTesting

@Suite("Validator Tests")
struct UnitTestingTests {
    
    @Test("Valid inputs pass validation")
    func validInputsPassValidation() {
        let result = validateUserInputs(name: "Tess Sterling",
                                        email: "tsterling@nautilus.edu.sap",
                                        age: 25)
        #expect(result == nil)
    }
    
    @Test("Empty name returns error")
    func emptyNameReturnsError() {
        let result = validateUserInputs(name: "",
                                        email: "tsterling@nautilus.edu.sap",
                                        age: 25)
        #expect(result == "Error: name cannot be empty")
    }
    
    @Test("Invalid email returns error")
    func invalidEmailReturnsError() {
        let result = validateUserInputs(name: "Tess Sterling",
                                        email: "notanemail",
                                        age: 25)
        #expect(result == "Error: invalid email")
    }
    
    @Test("Underage returns error")
    func underageReturnsError() {
        let result = validateUserInputs(name: "Tess Sterling",
                                        email: "tsterling@nautilus.edu.sap",
                                        age: 16)
        #expect(result == "Error: You must be 18 or older")
    }
    
    @Test("Exactly 18 passes validation")
    func exactlyEighteenPassesValidation() {
        let result = validateUserInputs(name: "Tess Sterling",
                                        email: "tsterling@nautilus.edu.sap",
                                        age: 18)
        #expect(result == nil)
    }
}
