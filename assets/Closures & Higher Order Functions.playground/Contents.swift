import Foundation

let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

// map (transform each element)
let squared = numbers.map { $0 * $0 }
print(squared)

// filter (keep elements matching condition)
let evens = numbers.filter { $0 % 2 == 0 }
print(evens)

// reduce (combine into single value)
let sum = numbers.reduce(0) { $0 + $1 }
print(sum)

// chaining
let sumOfSquaredEvens = numbers
    .filter { $0 % 2 == 0 }
    .map { $0 * $0 }
    .reduce(0, +)
print(sumOfSquaredEvens)

// compactMap (map + unwrap optionals)
let strings = ["1", "2", "three", "4", "five"]
let parsed = strings.compactMap { Int($0) }
print(parsed)  // [1, 2, 4]

// sorted
let names = ["Tess", "Ren", "Scylla"]
let sorted = names.sorted { $0 < $1 }
print(sorted)

// Closure syntax progression
let multiply: (Int, Int) -> Int = { (a: Int, b: Int) -> Int in return a * b }
let multiplyShort: (Int, Int) -> Int = { $0 * $1 }
print(multiply(3, 4))
print(multiplyShort(3, 4))

// Trailing closure syntax
func performOperation(_ a: Int, _ b: Int, operation: (Int, Int) -> Int) -> Int {
    return operation(a, b)
}

let result = performOperation(10, 5) { $0 + $1 }
print(result)

// @escaping (closure outlives the function call)
func fetchData(completion: @Sendable @escaping (String) -> Void) {
    DispatchQueue.global().async {
        completion("Data loaded")
    }
}

fetchData { print($0) }
