import Foundation

// Custom error type
enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingFailed(reason: String)
    case unauthorized
}

// Function that throws
func fetchUser(from url: String) throws -> String {
    guard url.hasPrefix("https") else {
        throw NetworkError.invalidURL
    }
    guard !url.isEmpty else {
        throw NetworkError.noData
    }
    return "User data from \(url)"
}

// try/catch
do {
    let data = try fetchUser(from: "https://api.example.com/user")
    print(data)
} catch NetworkError.invalidURL {
    print("Invalid URL provided")
} catch NetworkError.noData {
    print("No data received")
} catch NetworkError.decodingFailed(let reason) {
    print("Decoding failed: \(reason)")
} catch {
    print("Unexpected error: \(error)")
}

// try? returns optional
let result = try? fetchUser(from: "http://insecure.com")
print(result ?? "Failed silently")

// try! crashes if error thrown — use only when failure is impossible
// let forced = try! fetchUser(from: "https://safe.com")

// Rethrowing functions
func process(_ value: String, transform: (String) throws -> String) rethrows -> String {
    return try transform(value)
}

let processed = try? process("hello") { input in
    guard !input.isEmpty else { throw NetworkError.noData }
    return input.uppercased()
}
print(processed ?? "Failed")
