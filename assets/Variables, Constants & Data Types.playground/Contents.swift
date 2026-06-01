import Foundation

// MARK: - Constants & Variables

let maximumLoginAttempts: Int = 3       // constant
var currentLoginAttempts: Int = 0       // variable

// Swift infers types, explicit annotation is optional
let appName = "Focus Bear"              // inferred as String
var isAuthenticated = false             // inferred as Bool

// MARK: - Basic Data Types

// Integer types
let age: Int = 22
let year: UInt = 2026                   // unsigned, no negatives
let byteValue: UInt8 = 255              // 0-255

// Floating point
let pi: Double = 3.14159265358979       // 64-bit, preferred
let approximation: Float = 3.14         // 32-bit, less precise

// Boolean
let isMacDeveloper: Bool = true

// String
let greeting: String = "Hello, Sannidhya"
let greetAndAsk = """
    Hello, Sannidhya
    Are you playing around in Xcode Playground?
    """

// Character
let initial: Character = "S"

// MARK: - Type Safety

// Swift is strongly typed, so this won't compile:
// var score: Int = "ten"  // error: cannot convert String to Int

// Explicit conversion required
let intValue: Int = 42
let doubleValue: Double = Double(intValue)   // explicit cast

// MARK: - Optionals

// A value that may or may not exist
var username: String? = nil             // Optional String, currently nil
username = "sannidhyaroy"

// Forced unwrap, crashes if nil, avoid in production
let name = username!

// Safe unwrap with if let
if let unwrappedName = username {
    print("Hello, \(unwrappedName)")
}

// Nil coalescing, provide a default
let displayName = username ?? "Anonymous"

// MARK: - Type Aliases

typealias UserID = Int
typealias CompletionHandler = (Bool, Error?) -> Void

let userID: UserID = 12345              // same as Int, more expressive

// MARK: - Collections

// Array (ordered, typed)
var habits: [String] = ["Exercise", "Read", "Meditate"]
habits.append("Code")

// Dictionary (key-value pairs)
var scores: [String: Int] = ["Alice": 95, "Bob": 87]
scores["Charlie"] = 92

// Set (unordered, unique values)
var tags: Set<String> = ["swift", "macos", "apple"]
tags.insert("xcode")

// Tuple (fixed grouping of values)
let coordinates: (Double, Double) = (12.9716, 77.5946)
let (lat, lon) = coordinates            // destructuring

// Named tuple
let device = (name: "MacBook Pro", year: 2020, chip: "M1")
let deviceChip = device.chip

// MARK: - Type Inference in Practice

// Swift almost always infers correctly
let numbers = [1, 2, 3, 4, 5]          // [Int]
let mixed: [Any] = [1, "two", 3.0]     // explicit Any required for mixed types

print("Done!")
