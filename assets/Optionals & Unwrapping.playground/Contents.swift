import Foundation

// if let
var email: String? = "tsterling@nautilus.edu.sap"

if let unwrapped = email {
    print("Email: \(unwrapped)")
}

// guard let, early exit pattern
func greetUser(name: String?) {
    guard let name = name else {
        print("No name provided")
        return
    }
    print("Hello, \(name)")
}

greetUser(name: "Tess Sterling")
greetUser(name: nil)

// if let chaining
var city: String? = "Nautilus"
var country: String? = "Saphira"
var planet: String? = "1544b"


if let city = city, let country = country, let planet = planet {
    print("Location: \(city), \(country), \(planet)")
} else if let city = city, let country = country {
    print("Location: \(city), \(country)")
}

// Optional chaining
struct Address {
    var city: String
}

struct ResearchDivision {
    var address: Address?
}

let user = ResearchDivision(address: Address(city: "Biolume"))
print(user.address?.city ?? "No city")

// Nil coalescing
let username: String? = nil
let displayName = username ?? "You have restricted access to saphira.gov! The network team will be alerted!"
print(displayName)

// try? returns optional
func riskyOperation() throws -> String {
    throw NSError(domain: "com.saphira.coregrid.containment-fault", code: 1544)
}

let result = try? riskyOperation()
print(result ?? "WARNING: Biolume Perimeter Breach! Connection severed by Core Grid Firewall! Mainframe OFFLINE!")
