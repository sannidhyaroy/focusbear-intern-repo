# Mock API Testing

## The Critical Role of Mocking in Network Engineering

Relying entirely on live backend services during development introduces fragile dependencies into the engineering workflow. Live development and staging environments are prone to unexpected connection disruptions, breaking API contract changes, or strict rate-limiting rules that stall local testing loops. To build resilient apps, the app layout must isolate its data-parsing code and local state machines from these external network fluctuations.

Mock API testing bridges this gap by mimicking remote server behaviors over real HTTP transport layers. Instead of writing complex, hardcoded mock data injections directly inside application structures, the app can hit controlled web interfaces. This allows engineering pipelines to test how the system manages successful network responses, empty state payloads, and catastrophic structural drift deterministically.

### Integration Strategies: JSONPlaceholder vs. Beeceptor

| Service Platform    | Base Platform Access                   | Primary Use Case                           | Architectural Advantage                                                                                                                                                                                        |
| :------------------ | :------------------------------------- | :----------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **JSONPlaceholder** | `https://jsonplaceholder.typicode.com` | Standard REST CRUD validation              | Simulates a live, ready-made database layout featuring standard resources (such as `/posts`, `/todos`, and `/users`) out of the box with zero runtime configuration.                                           |
| **Beeceptor**       | `https://beeceptor.com`                | Edge-case, latency, and failure validation | Provides a dashboard to build completely custom path routing rules, intercept payload bodies, override HTTP status codes (e.g., 422 Unprocessable Entity, 500 Server Error), and artificially delay responses. |

**Note on the Modern Development Tooling Ecosystem:** The specification for this module originally called for **Mocky** (`mocky.io`). However, the classic Mocky platform and its subdomains (such as `designer.mocky.io`) have become deprecated, unmaintained, and return standard server `404 Not Found` or network timeout errors. To keep this integration documentation functional and production-ready, this guide swaps the defunct Mocky service for **Beeceptor**, a widely adopted modern alternative that delivers the exact same zero-signup, instant mock configuration features.

---

## Implementation: Unified Mock API Testing Environment

The implementation below sets up a structured, decoupled networking engine. It targets a dependable REST mock container (`JSONPlaceholder`) to verify standard models, alongside a custom, configurable proxy subsystem (`Beeceptor`) to explicitly capture and log handled backend failures.

```swift
import Foundation

struct MockTodo: Codable {
    let id: Int
    let userId: Int
    let title: String
    let completed: Bool
}

/// Bounded routing layout managing connections to active public mock infrastructures.
enum MockWorkspaceRoute {
    case retrieveStandardTodo(id: Int)
    case simulateInternalServerError(subdomain: String)
    
    var url: URL? {
        switch self {
        case .retrieveStandardTodo(let id):
            // Accesses a stable, pre-configured public mock endpoint collection
            return URL(string: "https://jsonplaceholder.typicode.com/todos/\(id)")
            
        case .simulateInternalServerError(let subdomain):
            // Accesses a custom proxy bucket created on the active Beeceptor interface
            return URL(string: "https://\(subdomain).proxy.beeceptor.com/v1/error-trigger")
        }
    }
}

/// Dedicated testing service used to isolate network parsing loops from live production databases.
final class MockApiService {
    
    private let session: URLSession
    
    /// Initializes the testing context, supporting standard system sessions or custom mock containers.
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    /// Connects to a mock host route to assert model parsing boundaries and trace transaction results.
    func verifyMockTodoFetch(endpoint: MockWorkspaceRoute) async throws -> MockTodo {
        guard let requestURL = endpoint.url else {
            throw URLError(.badURL)
        }
        
        print("[+] Commencing mock environment handshake at: \(requestURL.absoluteString)")
        
        // Execute the non-blocking data task over standard network sockets
        let (data, response) = try await session.data(from: requestURL)
        
        // Verify that the transport envelope conforms to standard HTTP response metadata structures
        guard let httpResponse = response as? HTTPURLResponse else {
            print("[-] Transport Failure: Connection returned an uninterpretable protocol layout.")
            throw URLError(.badServerResponse)
        }
        
        print("[+] Mock subsystem responded with HTTP status code: \(httpResponse.statusCode)")
        
        // Enforce strict status validation rules prior to passing data onward
        guard (200...299).contains(httpResponse.statusCode) else {
            print("[-] Handled Edge Case: Intercepted an intentional failure state from the mock dashboard.")
            throw URLError(.badServerResponse)
        }
        
        // Map the payload directly to the internal data configuration
        do {
            let decoder = JSONDecoder()
            let parsedTodo = try decoder.decode(MockTodo.self, from: data)
            print("[+] Success: The incoming JSON buffer matches the structural requirements of the app model.")
            return parsedTodo
        } catch {
            print("[-] Structural Mismatch: The payload layout deviated from local data contracts.")
            throw error
        }
    }
}
```

---

## Architectural Mapping & Error Resolution Strategies

* **Simulating Structural Payload Drift:** When backend architecture teams alter database structures, updating the mock payload rules inside the tool dashboard allows developers to proactively test upcoming contract updates. This catches missing object keys, unexpected null mutations, or array type shifts locally before code updates hit live testing channels.
* **Validating Error Handling Code Paths:** Relying purely on live environments makes it difficult to test rare system states like a `503 Service Unavailable` page or an expired authorization token. Setting custom route responses on the mock service forces the app through these precise code paths, validating that user interface structures change gracefully instead of stalling the app execution thread.
* **Simulating Real-World Latency and Timeouts:** High-speed office Wi-Fi can mask performance bottlenecks. Using mock dashboard rules to apply a 6-second artificial response delay to an endpoint allows engineering teams to stress-test local connection rules. This verifies that loading indicator animations behave cleanly, and that operations cancel quickly if a user backs away from an active interface container.
