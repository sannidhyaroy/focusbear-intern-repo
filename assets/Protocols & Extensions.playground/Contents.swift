import Foundation

// Protocol definition
protocol Describable {
    var description: String { get }
    func describe()
}

// Default implementation via extension
extension Describable {
    func describe() {
        print(description)
    }
}

// Conformance
struct Device: Describable {
    var name: String
    var year: Int

    var description: String {
        return "\(name) (\(year))"
    }
}

let macbook = Device(name: "MacBook Pro", year: 2020)
macbook.describe()  // uses default implementation

// Protocol with multiple requirements
protocol Persistable {
    func save()
    func load() -> String
}

// Protocol composition
typealias PersistableDescribable = Persistable & Describable

// Extension on existing type
extension String {
    var isValidEmail: Bool {
        return contains("@") && contains(".")
    }

    func truncated(to length: Int) -> String {
        if count <= length { return self }
        return String(prefix(length)) + "..."
    }
}

print("tsterling@nautilus.edu.sap".isValidEmail)  // true
print("notanemail".isValidEmail)             // false
print("Hello, World!".truncated(to: 5))      // Hello...

// Protocol as type
protocol Shape {
    var area: Double { get }
}

struct Circle: Shape {
    var radius: Double
    var area: Double { return .pi * radius * radius }
}

struct Rectangle: Shape {
    var width: Double
    var height: Double
    var area: Double { return width * height }
}

let shapes: [Shape] = [Circle(radius: 5), Rectangle(width: 4, height: 6)]
shapes.forEach { print("Area: \($0.area)") }
