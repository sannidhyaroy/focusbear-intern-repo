# Code Smells

Code smells are surface indicators of deeper problems in code. They are not bugs, the code may work correctly, but they signal that the design is likely to cause problems as the codebase grows. The term was popularised by Martin Fowler in *Refactoring: Improving the Design of Existing Code*.

---

## Magic Numbers & Strings

**Smell:** Hardcoded values with no explanation of what they mean.

```swift
// Before
if user.age >= 18 {
    price = price * 0.85
    if subscriptionDays > 365 {
        price = price * 0.90
    }
}
```

The numbers `18`, `0.85`, `0.90`, and `365` are magic. What does 18 mean in this context? What is 0.85, a discount? A tax? Why 365?

```swift
// After
let minimumEligibleAge = 18
let standardDiscountMultiplier = 0.85
let loyaltyDiscountMultiplier = 0.90
let loyaltyThresholdDays = 365

if user.age >= minimumEligibleAge {
    price = price * standardDiscountMultiplier
    if subscriptionDays > loyaltyThresholdDays {
        price = price * loyaltyDiscountMultiplier
    }
}
```

Named constants make the intent self-documenting. Changing the loyalty threshold from 365 to 180 requires one edit in one place.

---

## Long Functions

**Smell:** A function that does too many things, making it hard to understand, test, or change any single part of it.

Already covered in depth in the [Writing Small Focused Functions](https://github.com/sannidhyaroy/focusbear-intern-repo/blob/main/docs/clean-code/clean_code.md#writing-small-focused-functions) section. The rule of thumb: if a function needs internal comments to explain what each section does, each section should be its own function.

---

## Duplicate Code

**Smell:** The same logic copy-pasted in multiple places.

Already covered in depth in the [Avoiding Code Duplication](https://github.com/sannidhyaroy/focusbear-intern-repo/blob/main/docs/clean-code/clean_code.md#avoiding-code-duplication) section. Duplicate code is the most dangerous smell because changes must be applied everywhere the logic exists, and missing one copy creates silent inconsistency.

---

## Large Classes (God Objects)

**Smell:** A class that knows too much and does too much, accumulating responsibilities that should belong to separate classes.

```swift
// Before: one class handles everything
class AppManager {
    var users: [User] = []
    var products: [Product] = []
    var orders: [Order] = []
    var currentUser: User?

    func registerUser(name: String, email: String) { ... }
    func loginUser(email: String, password: String) { ... }
    func logoutUser() { ... }
    func fetchProducts() { ... }
    func filterProducts(by category: String) { ... }
    func addToCart(product: Product) { ... }
    func processPayment(amount: Double) { ... }
    func sendConfirmationEmail(to user: User) { ... }
    func generateInvoice(for order: Order) { ... }
    func updateInventory(for product: Product) { ... }
}
```

`AppManager` has at least five distinct responsibilities: user authentication, product management, cart management, payment processing, and notifications. Any change to payment logic risks breaking authentication logic because they share the same class.

```swift
// After: responsibilities separated
class AuthService {
    func register(name: String, email: String) { ... }
    func login(email: String, password: String) { ... }
    func logout() { ... }
}

class ProductCatalog {
    func fetchAll() { ... }
    func filter(by category: String) { ... }
}

class CartService {
    func addItem(_ product: Product) { ... }
}

class PaymentService {
    func processPayment(amount: Double) { ... }
}

class NotificationService {
    func sendConfirmation(to user: User) { ... }
}
```

Each class now has one reason to change. The blast radius of any modification is contained to the relevant class.

---

## Deeply Nested Conditionals

**Smell:** Multiple levels of nested `if/else` that force the reader to track multiple conditions simultaneously.

Already partially covered in [earlier sections](https://github.com/sannidhyaroy/focusbear-intern-repo/blob/main/docs/clean-code/clean_code.md). The solution is guard clauses for early returns and extracting complex conditions into well-named functions.

```swift
// Before: arrow code
func processPayment(user: User?, amount: Double?) {
    if let user = user {
        if user.isVerified {
            if let amount = amount {
                if amount > 0 {
                    if user.balance >= amount {
                        // actual logic buried five levels deep
                        user.balance -= amount
                    }
                }
            }
        }
    }
}

// After: guard clauses flatten the structure
func processPayment(user: User?, amount: Double?) {
    guard let user = user else { return }
    guard user.isVerified else { return }
    guard let amount = amount, amount > 0 else { return }
    guard user.balance >= amount else { return }

    user.balance -= amount
}
```

The guard version has the same logic in half the lines with zero nesting.
Each precondition is visible and independently understandable.

---

## Commented-Out Code

**Smell:** Code that has been disabled by commenting it out rather than deleted.

```swift
// Before
func calculateTotal(items: [Item]) -> Double {
    var total = 0.0
    for item in items {
        total += item.price
        // total += item.price * item.taxRate
        // if item.isDiscounted {
        //     total -= item.discountAmount
        // }
    }
    // print("Total calculated: \(total)")
    return total
}
```

Commented-out code is clutter. It raises questions: was this removed intentionally? Should it come back? Is it still correct? Version control preserves deleted code, `git log` and `git blame` can recover anything that was deleted. Commented-out code should be deleted without hesitation.

```swift
// After
func calculateTotal(items: [Item]) -> Double {
    return items.reduce(0.0) { $0 + $1.price }
}
```

---

## Inconsistent Naming

**Smell:** Variables and functions in the same codebase follow different naming conventions or use names that don't reflect their purpose.

```swift
// Before: inconsistent naming throughout
func get_user_data(UserId: Int) -> [String: Any] {
    let tmp = fetchFromDB(id: UserId)
    let x = tmp["profile"]
    let flag = tmp["isActive"] as? Bool
    return ["userData": x, "status": flag as Any]
}
```

Problems: `get_user_data` uses snake_case while Swift convention is camelCase. `UserId` capitalises the wrong part. `tmp`, `x`, and `flag` are meaningless. The return dictionary uses string keys that could be misspelled by callers.

```swift
// After
struct UserProfile {
    let profile: Profile
    let isActive: Bool
}

func fetchUser(byId userId: Int) -> UserProfile? {
    guard let data = fetchFromDB(id: userId) else { return nil }
    guard let profile = data["profile"] as? Profile,
          let isActive = data["isActive"] as? Bool else { return nil }
    return UserProfile(profile: profile, isActive: isActive)
}
```

Consistent camelCase, meaningful names, a typed return value instead of a stringly-typed dictionary.

---

## How Did Refactoring Improve Readability and Maintainability?

Each smell addressed above has a different mechanism but the same root cause: the code is harder to read or change than it needs to be. Magic numbers require the reader to guess intent. Long functions require holding too much in working memory. God objects create unpredictable coupling. Nested conditionals create visual complexity that obscures the actual logic.

Refactoring these smells does not change what the code does, it changes how clearly the code communicates what it does. A codebase free of common smells is one where changes are local, failures are traceable, and new contributors can orient themselves without a guided tour.

## How Can Avoiding Code Smells Make Future Debugging Easier?

Code smells make bugs harder to find in two ways. First, they obscure intent, when you cannot quickly understand what code is supposed to do, you cannot quickly identify when it is doing the wrong thing. Second, they increase coupling, a bug in a God Object or duplicated code can manifest in multiple places, making the root cause hard to isolate.

Clean code fails loudly and locally. A well-named function with guard clauses and typed errors fails at the exact point of the problem and tells you why. A deeply nested function with magic numbers and force unwraps fails somewhere downstream with a crash that points to a symptom rather than a cause.

The investment in clean code is an investment in debuggability. Every code smell you eliminate is a category of confusion you will not have to untangle at 2AM when something breaks in production.
