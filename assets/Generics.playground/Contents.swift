import Foundation

// Generic function
func swap<T>(_ a: inout T, _ b: inout T) {
    let temp = a
    a = b
    b = temp
}

var x = 10
var y = 20
swap(&x, &y)
print("x: \(x), y: \(y)")

var firstName = "Tess"
var lastName = "Sterling"
swap(&firstName, &lastName)
print("\(firstName) \(lastName)")

// Generic type
struct Stack<Element> {
    private var storage: [Element] = []

    mutating func push(_ element: Element) {
        storage.append(element)
    }

    mutating func pop() -> Element? {
        return storage.popLast()
    }

    var top: Element? {
        return storage.last
    }

    var isEmpty: Bool {
        return storage.isEmpty
    }
}

var intStack = Stack<Int>()
intStack.push(1)
intStack.push(2)
intStack.push(3)
print(intStack.pop() ?? "empty")
print(intStack.top ?? "empty")

// Type constraints
func findMax<T: Comparable>(_ array: [T]) -> T? {
    guard !array.isEmpty else { return nil }
    return array.max()
}

print(findMax([3, 1, 4, 1, 5, 9, 2, 6]) ?? "empty")
print(findMax(["Saphira", "Biolume", "Nautilus"]) ?? "empty")

// where clause
func areEqual<T: Equatable, U: Equatable>(_ a: T, _ b: U) -> Bool where T == U {
    return a == b
}

print(areEqual(42, 42))
print(areEqual("hello", "1544b"))

// Generic protocol with associated type
protocol Container {
    associatedtype Item
    var count: Int { get }
    mutating func add(_ item: Item)
    func get(at index: Int) -> Item?
}
