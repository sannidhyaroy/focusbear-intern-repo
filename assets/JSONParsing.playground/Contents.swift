import Foundation

struct ProjectMetric: Codable {
    let metricId: String
    let requestCount: Int
    let throughputMs: Double
    let isHealthy: Bool
    let metadataTags: [String]
}

// Simulated data block capturing raw server response text
let jsonSourceString = """
{
    "metric_id": "biolume-subsystem-04",
    "request_count": 14285,
    "throughput_ms": 12.45,
    "is_healthy": true,
    "metadata_tags": ["gateway-core", "bo-south", "optimized"]
}
"""

func executePlaygroundDecoding() {
    // Convert the textual workspace layout into an accessible memory buffer
    guard let payloadData = jsonSourceString.data(using: .utf8) else {
        print("[-] Failure: Unable to convert raw string source into a standard byte buffer.")
        return
    }
    
    let parser = JSONDecoder()
    
    // Automatically match snake_case fields to camelCase properties
    parser.keyDecodingStrategy = .convertFromSnakeCase
    
    do {
        // Parse the raw memory layout directly into the data model structure
        let metric = try parser.decode(ProjectMetric.self, from: payloadData)
        
        print("[+] Execution successful: Raw JSON successfully mapped to Swift memory models.")
        print("--------------------------------------------------")
        print("Identifier:  \(metric.metricId)")
        print("Requests:    \(metric.requestCount)")
        print("Latency:     \(metric.throughputMs) ms")
        print("Status:      \(metric.isHealthy ? "Operational" : "Faulted")")
        print("Tags:        \(metric.metadataTags.joined(separator: ", "))")
        print("--------------------------------------------------")
        
    } catch let decodingError as DecodingError {
        // Detailed analysis of data schema alignment discrepancies
        switch decodingError {
        case .typeMismatch(let targetType, let context):
            print("[-] Schema Error - Type Mismatch:")
            print("    Expected type: \(targetType)")
            print("    Context path:  \(context.codingPath.map { $0.stringValue })")
            print("    Description:   \(context.debugDescription)")
            
        case .valueNotFound(let targetType, let context):
            print("[-] Schema Error - Missing Value:")
            print("    Expected type: \(targetType)")
            print("    Context path:  \(context.codingPath.map { $0.stringValue })")
            print("    Description:   \(context.debugDescription)")
            
        case .keyNotFound(let identityKey, let context):
            print("[-] Schema Error - Missing Key Struct:")
            print("    The property key '\(identityKey.stringValue)' was not found in the payload.")
            print("    Context path:  \(context.codingPath.map { $0.stringValue })")
            print("    Description:   \(context.debugDescription)")
            
        case .dataCorrupted(let context):
            print("[-] Structural Error - Payload Corrupted:")
            print("    The input buffer is not valid JSON text layout.")
            print("    Description:   \(context.debugDescription)")
            
        @unknown default:
            print("[-] Unhandled, anomalous decoding state encountered.")
        }
    } catch {
        // Exhaustive fallback catching non-decoding anomalies to satisfy compiler constraints
        print("[-] Unexpected non-decoding failure encountered: \(error.localizedDescription)")
    }
}

executePlaygroundDecoding()
