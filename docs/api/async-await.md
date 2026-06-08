# Async/Await Networking

## The Evolution of macOS Concurrency

Historically, asynchronous data operations on macOS relied on completion handlers and Grand Central Dispatch (GCD) closures. While functional, closure-based execution models separate the point of resource initialization from the point of data return. This asynchronous decoupling forces the application structure into deeply nested closures, frequently referred to as "callback hell", making control flow complex to track, audit, and maintain.

Modern macOS development implements structural concurrency using `async/await`. This language-level feature transforms asynchronous instruction streams, allowing non-blocking tasks to be written sequentially from top to bottom. The compilation layer handles the generation of execution suspensions automatically, ensuring code reads like synchronous logic while running fluidly across system-managed background thread resources.

## Architectural Tradeoffs: Completion Handlers vs. Async/Await

| Metric                | Legacy Closures (`completionHandler:`)          | Modern Concurrency (`async/await`)      |
| :-------------------- | :---------------------------------------------- | :-------------------------------------- |
| **Control Flow**      | Nested callback blocks; nested indentations     | Linear, sequential code paths           |
| **Error Propagation** | Manual tracking via `Result<Data, Error>` enums | Standard Swift throw-and-catch blocks   |
| **Thread Management** | Manual dispatch back to `DispatchQueue.main`    | Thread context jumps managed by runtime |
| **Memory Mechanics**  | Explicit capture lists required (`[weak self]`) | Automatic life-cycle preservation       |

---

## Implementation: Concurrency Paradigm Comparison

The implementation below demonstrates a structural side-by-side migration. The code shows a traditional callback-based configuration followed by its direct architectural conversion into a structured `async/await` network pipeline.

```swift
import Foundation

struct RepositoryMetric: Codable {
    let repositoryId: String
    let syncStatus: String
}

struct ConcurrencyConverter {
    
    private static let session = URLSession.shared
    private static let targetURL = URL(string: "https://api.saphira.gov/v1/sync/status")!
    
    // LEGACY PARADIGM: Completion Handler Callback Loop
    
    /// Fetches tracking data using nested completion blocks and manual Result wrapping.
    static func fetchMetricsLegacy(completion: @escaping (Result<RepositoryMetric, Error>) -> Void) {
        
        // Outbound transaction is initiated with a callback closure assignment
        session.dataTask(with: targetURL) { data, response, error in
            
            // Explicit error checking required for transport failures
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Structural validation of individual transport response objects
            guard let httpResponse = response as? HTTPURLResponse, 
                  (200...299).contains(httpResponse.statusCode) else {
                let statusError = NSError(domain: "NetworkError", code: 0, userInfo: nil)
                completion(.failure(statusError))
                return
            }
            
            // Safety handling of unallocated data memory buffers
            guard let data = data else {
                let dataError = NSError(domain: "NoDataError", code: 0, userInfo: nil)
                completion(.failure(dataError))
                return
            }
            
            // Parsing pass must manually wrap errors to avoid unhandled failures
            do {
                let decoder = JSONDecoder()
                let metrics = try decoder.decode(RepositoryMetric.self, from: data)
                completion(.success(metrics))
            } catch {
                completion(.failure(error))
            }
        }.resume() // Omission of resume fails to boot the task pipeline entirely
    }
    
    // MODERN PARADIGM: Structured Async/Await Pipeline
    
    /// Fetches structural analytics sequentially using system-managed async continuations.
    static func fetchMetricsModern() async throws -> RepositoryMetric {
        
        // System suspends execution at the await boundary without stalling the execution thread
        let (data, response) = try await session.data(from: targetURL)
        
        // Non-nested validation layer checks status code consistency inline
        guard let httpResponse = response as? HTTPURLResponse, 
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        // Errors throw upwards naturally to the calling function block
        let decoder = JSONDecoder()
        let metrics = try decoder.decode(RepositoryMetric.self, from: data)
        
        return metrics
    }
}
```

---

## Thread Lifecycle and Actor Context Preservation

- **Suspension Mechanics:** When the application encounters the `await` keyword, the executing thread is completely relinquished back to the system thread pool. The system assigns the network transfer workload to background daemon layers. Once the network payload returns, the runtime schedules the remainder of the function on an available thread.
- **Elimination of Retain Loops:** Legacy completion handlers require adding `[weak self]` capture lists to prevent object retention leaks when updates touch long-lived user interface classes. Because `async/await` breaks down execution blocks into distinct cooperative steps rather than lingering blocks, memory management risks are significantly minimized.
- **Main Thread Re-entry:** When processing data using legacy structures, background threads must explicitly bounce UI updates back to the main layout loop via `DispatchQueue.main.async`. Under modern structured frameworks, decorating a calling container with `@MainActor` ensures re-entry to the main rendering pipeline happens automatically upon task resumption.
