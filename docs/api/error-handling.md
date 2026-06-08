# Handling Network Errors

## The Anatomy of Network Failures

In a robust macOS application, network requests can fail at multiple distinct levels of the system stack. Writing resilient network code requires moving beyond generic catch blocks and implementing precise error differentiation. A standard network request lifecycle can fail at three main points:

- **Transport Layer:** Local hardware disconnects, DNS resolution failures, and connection timeouts managed by `URLError`.
- **Server/Protocol Layer:** Successful socket communication that returns a non-200 HTTP status code, managed via `HTTPURLResponse`.
- **Application Layer:** Successful data delivery that fails to map to local data structures due to payload divergence, managed via `DecodingError`.

## Custom Error Enumerations

To prevent system-level exceptions from leaking into the user interface layer, the networking subsystem should transform raw errors into tightly bounded, domain-specific enums. Conforming these custom enums to the standard `LocalizedError` protocol allows the application to cleanly expose user-readable descriptions while maintaining detailed debugging information under the hood.

---

## Implementation: Comprehensive Error Parsing Pipeline

The implementation below demonstrates how to capture, categorize, and transform transport, protocol, and serialization failures into a cleanly bounded application error type.

```swift
import Foundation

/// Bounded domain errors isolating distinct failure vectors across the network stack.
enum NetworkError: LocalizedError {
    case invalidResponse
    case serverSideFault(statusCode: Int)
    case requestTimeout
    case connectionFailure(String)
    case payloadMismatched(String)
    case anonymous(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "The server returned an uninterpretable response format."
        case .serverSideFault(let statusCode):
            return "The remote system encountered an operational error. Status code: \(statusCode)."
        case .requestTimeout:
            return "The communication window timed out before completing the transaction."
        case .connectionFailure(let reason):
            return "A network transport failure occurred: \(reason)."
        case .payloadMismatched(let context):
            return "The downloaded data structure did not match local schemas: \(context)."
        case .anonymous(let error):
            return error.localizedDescription
        }
    }
}

struct ErrorHandlingNetworkService {
    
    private static let session: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 5.0 // Short timeout to explicitly catch timeout states
        return URLSession(configuration: config)
    }()
    
    /// Executes a request and transforms systemic failures into explicit domain enums.
    static func processRequest(targeting url: URL) async throws -> Data {
        let request = URLRequest(url: url)
        
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.serverSideFault(statusCode: httpResponse.statusCode)
            }
            
            return data
            
        } catch let urlError as URLError {
            // Mapping specific transport layer failures
            switch urlError.code {
            case .timedOut:
                print("[-] Hardware/Transport boundary intercepted: Request timed out.")
                throw NetworkError.requestTimeout
            case .notConnectedToInternet, .networkConnectionLost:
                print("[-] Hardware/Transport boundary intercepted: Missing or broken connection.")
                throw NetworkError.connectionFailure(urlError.localizedDescription)
            default:
                throw NetworkError.anonymous(urlError)
            }
            
        } catch let decodingError as DecodingError {
            // Mapping schema mismatch issues at the application layer
            let clearContext: String
            switch decodingError {
            case .keyNotFound(let key, _):
                clearContext = "Missing property key: \(key.stringValue)"
            case .typeMismatch(let target, _):
                clearContext = "Type divergence. Target expected type: \(target)"
            case .valueNotFound(let type, _):
                clearContext = "Null constraint violation for type: \(type)"
            case .dataCorrupted(_):
                clearContext = "Malformed JSON content structure."
            @unknown default:
                clearContext = "Anomalous structural extraction error."
            }
            
            print("[-] Application data parsing boundary intercepted: \(clearContext)")
            throw NetworkError.payloadMismatched(clearContext)
            
        } catch let networkError as NetworkError {
            // Pass through internal enums thrown from the guard statements
            throw networkError
            
        } catch {
            // Catch-all for unmanaged system errors
            throw NetworkError.anonymous(error)
        }
    }
}
```

---

## Architectural Mapping & Error Resolution Strategies

- **Timeout Boundaries:** Modifying `timeoutIntervalForRequest` on `URLSessionConfiguration` sets the maximum time a task can wait for incoming data before breaking. When the limit is reached, the transaction drops immediately and throws a `URLError` with the `.timedOut` code, allowing the application to offer a localized retry option.
- **Isolating Structural Drift:** If an production API modifies a payload structure without changing the API version number, downstream clients will trigger the `DecodingError` loop. Logging the specific context path via `decodingError` parameters allows telemetry tools to quickly isolate which field broke the schema contract.
- **Graceful UI Degradation:** Relying on `LocalizedError` allows upper-level view components to present user-facing alerts using `error.localizedDescription`, while low-level diagnostics can dump the raw enum parameters into system logs for accurate crash-trace auditing.
