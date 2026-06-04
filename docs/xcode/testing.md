# Unit Tests in Xcode

## Project

The test project is in [`UnitTesting`](../../assets/UnitTesting).

## What is Unit Testing?

Unit tests verify that individual functions and components behave correctly in isolation. The test target is separate from the app target and is never included in the release build.

## Testing Frameworks

Xcode supports two unit testing frameworks:

**Swift Testing** is the modern framework introduced in Xcode 16. Tests are marked with the `@Test` macro, assertions use `#expect`, and test groups use `@Suite`. No base class required. This is the preferred framework for new Swift projects.

**XCTest** is the legacy framework. Test classes inherit from `XCTestCase`, test methods are prefixed with `test` for automatic discovery, and assertions use `XCTAssert*` functions. Still used for UI tests and performance tests where Swift Testing does not yet have equivalent APIs.

This project uses Swift Testing for unit tests and XCTest for UI tests, which is the setup Xcode generates when selecting "Swift Testing with XCTest UI Tests" as the testing system.

## Running Tests

`Cmd + U` runs all tests. `Cmd + Ctrl + U` runs the test file currently open in the editor. Individual tests can be run by clicking the diamond icon in the gutter next to each test function. Green means passing, red means failing.

## Test Structure

Swift Testing tests are plain structs or classes marked with `@Suite`. Each test function is marked with `@Test` and can include a display name as a string argument. No `setUp` or `tearDown` methods — use `init` and `deinit` instead.

## The App

A simple macOS form validator with three fields: Name, Email, and Age. Submitting the form runs `validateUserInputs` and displays either a success message or the specific validation error. The validator function is defined in `Validator.swift` and is independently testable without the UI.

## The Tests

Five Swift Testing unit tests cover the validator:

- Valid inputs pass validation and return nil
- Empty name returns the correct error message
- Invalid email format returns the correct error message
- Age below 18 returns the correct error message
- Exactly 18 passes validation (boundary condition)

## Parameterized Tests

The `ValidationMatrixTests` suite uses Swift Testing's `@Test(arguments:)` combined with `product(_:_:)` from `swift-algorithms` to generate 8 test cases from the cartesian product of all input combinations. Each combination runs as a separate named test case in the test navigator, making it easy to see exactly which input combination failed and why. This is covered in the [Frameworks and Packages](./packages.md) issue which adds `swift-algorithms` to the test target.

## Key Swift Testing APIs

`#expect` verifies a condition and reports a detailed failure message if it is false, including the actual values on both sides of the comparison.
`#expect(throws:)` verifies that an expression throws a specific error type.
`@Suite` groups related tests and can include shared setup logic.
`@Test` marks a function as a test case with an optional display name for the test navigator.

## Key XCTest Assertions

`XCTAssertEqual` verifies two values are equal.
`XCTAssertNil` verifies a value is nil.
`XCTAssertTrue` / `XCTAssertFalse` verifies a boolean condition.
`XCTAssertThrowsError` verifies a throwing expression throws an error.

## Screenshot

|                                    **Unit Testing Report**                                    |
| :-------------------------------------------------------------------------------------------: |
| ![Unit Testing Report](../../assets/onboarding/Screenshot%202026-06-04%20at%201.50.20 PM.png) |
|                    *9 tests passed with test plan across two test targets*                    |
