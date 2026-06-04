# Frameworks & Packages

## Swift Package Manager

Swift Package Manager is Apple's first-party dependency manager, integrated directly into Xcode. Packages are added via `File > Add Package Dependencies`, resolved automatically, and linked to specific targets. No separate tooling, no lockfile management, no Ruby environment, everything is handled natively by Xcode and the Swift compiler.

## Project

The package was added to the existing [`UnitTesting`](../../assets/UnitTesting) project from the previous issue, which already contained the form validator logic and Swift Testing unit tests.

## Added Package: `swift-algorithms`

[swift-algorithms](https://github.com/apple/swift-algorithms) is an open-source package by Apple that extends the Swift standard library with sequence and collection algorithms not available natively, like `product(_:_:)` for cartesian products, `chunked(by:)`, `uniqued()`, and `windows(ofCount:)`.

## How It Was Used

Rather than importing the package and calling one trivial function, `swift-algorithms` was used meaningfully in the test suite. The `product(_:_:)` function generates the cartesian product of two sequences, every combination of elements from both. Combined with Swift Testing's `@Test(arguments:)` parameterized test API, it generates a full validation matrix from three input arrays:

```swift
static var combinations: [(String, String, Int)] {
    product(product(names, emails), ages)
        .map { (nameEmail, age) in
            (nameEmail.0, nameEmail.1, age)
        }
}

@Test("Validation matrix", arguments: combinations)
func validationMatrix(name: String, email: String, age: Int) { ... }
```

This produces 8 parameterized test cases from 2 names × 2 emails × 2 ages, each running as a separate test in the test navigator. The standard library has no equivalent to `product(_:_:)`, this is exactly the kind of gap `swift-algorithms` fills.

The package was added to the `UnitTestingTests` target only, since that is the only target that uses it. The main app target and UI test target have no dependency on it.

## Why Swift Package Manager over CocoaPods or Carthage

Swift Package Manager (SPM) is integrated into Xcode with no additional tooling required. CocoaPods requires a Ruby environment and a separate `pod install` step. Carthage builds frameworks independently but requires manual linking. SPM handles everything natively and is the direction Apple is pushing the ecosystem, hence most major libraries now support it as their primary or only distribution method.

## Screenshots

|                                    Adding the package                                     |                                  Fetching and verifying                                  |
| :---------------------------------------------------------------------------------------: | :--------------------------------------------------------------------------------------: |
| ![Package Search](../../assets/onboarding/Screenshot%202026-06-04%20at%2012.17.51 PM.png) | ![Package Fetch](../../assets/onboarding/Screenshot%202026-06-04%20at%2012.18.15 PM.png) |
|                            *`swift-algorithms` package search*                            |                     *Fetching and verifying the package from source*                     |

|                                      Target selection                                       |                                      Package dependencies                                      |
| :-----------------------------------------------------------------------------------------: | :--------------------------------------------------------------------------------------------: |
| ![Target Selection](../../assets/onboarding/Screenshot%202026-06-04%20at%2012.20.05 PM.png) | ![Package Dependencies](../../assets/onboarding/Screenshot%202026-06-04%20at%201.40.32 PM.png) |
|                            *Selecting Target to add the package*                            |                              *Project Package Dependencies list*                               |

|                                      Test results                                      |
| :------------------------------------------------------------------------------------: |
| ![Test Results](../../assets/onboarding/Screenshot%202026-06-04%20at%201.50.20 PM.png) |
|                *9 tests passed with test plan across two test targets*                 |
