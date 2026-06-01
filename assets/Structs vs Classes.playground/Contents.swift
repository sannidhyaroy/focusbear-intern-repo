import Foundation

// Struct (value type)
struct Point {
    var x: Double
    var y: Double

    mutating func translate(dx: Double, dy: Double) {
        x += dx
        y += dy
    }
}

var pointA = Point(x: 0, y: 0)
var pointB = pointA     // copy
pointB.translate(dx: 5, dy: 5)

print("pointA: \(pointA.x), \(pointA.y)")  // 0, 0 (unaffected)
print("pointB: \(pointB.x), \(pointB.y)")  // 5, 5

// Class (reference type)
class Counter {
    var count: Int = 0

    func increment() {
        count += 1
    }
}

let counterA = Counter()
let counterB = counterA     // same reference
counterB.increment()

print("counterA: \(counterA.count)")  // 1 (affected)
print("counterB: \(counterB.count)")  // 1 (same object)

// Class inheritance
class Animal {
    var name: String

    init(name: String) {
        self.name = name
    }

    func speak() -> String {
        return "\(name) makes a sound"
    }
}

class Dog: Animal {
    override func speak() -> String {
        return "\(name) barks"
    }
}

let dog = Dog(name: "Bruno")
print(dog.speak())

// deinit only available in classes
class Resource {
    init() { print("Resource acquired") }
    deinit { print("Resource released") }
}

var resource: Resource? = Resource()
resource = nil  // triggers deinit
