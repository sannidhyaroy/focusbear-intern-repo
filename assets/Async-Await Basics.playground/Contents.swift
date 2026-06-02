import Foundation

enum ContainmentError: Error, CustomStringConvertible {
    case connectionSevered(sector: String)
    case firewallBlockade
    case reactorOverload(temperature: Double)
    
    var description: String {
        switch self {
        case .connectionSevered(let sector):
            return "CRITICAL FAILURE: Connection to Sector [\(sector)] severed by automated quarantine protocol!"
        case .firewallBlockade:
            return "SECURITY ALERT: Intrusion detected. Core Grid Firewall has blockaded the protocol!"
        case .reactorOverload(let temp):
            return "WARNING: Core Temperature at \(temp)°C. Thermal containment field destabilizing!"
        }
    }
}

// Basic Async Function
func fetchTelemetry(for sector: String) async throws -> String {
    // Simulating deep-ocean quantum network ping delay
    try await Task.sleep(nanoseconds: 1_200_000_000)
    
    // Simulate a containment failure if trying to poll the forbidden research zone
    if sector == "Biolume Perimeter" {
        throw ContainmentError.connectionSevered(sector: "Biolume Perimeter")
    }
    
    return "Telemetry [\(sector)]: Stable. Yield at 94.2%. Structural hull intact."
}

// Calling async function via top-level asynchronous Task
Task {
    do {
        let telemetry = try await fetchTelemetry(for: "Saphira-Grid-01")
        print(telemetry)
    } catch {
        print("Telemetry Error -> \(error)")
    }
}

// async let (Parallel Execution)
func synchronizeCoreGrids() async throws {
    async let saphira = fetchTelemetry(for: "Saphira Mainframe")
    async let nautilus = fetchTelemetry(for: "Nautilus Outpost")
    async let coreGrid = fetchTelemetry(for: "Core Grid Node B")

    // The await keyword is used once when combining the concurrent requests
    let reports = try await [saphira, nautilus, coreGrid]
    print("\n--- SYNCHRONIZATION COMPLETE ---")
    reports.forEach { print($0) }
}

Task {
    try? await synchronizeCoreGrids()
}

// Task Groups (Dynamic Parallelism)
func sweepAllClusters(_ clusters: [String]) async throws -> [String] {
    try await withThrowingTaskGroup(of: String.self) { group in
        for cluster in clusters {
            group.addTask {
                try await fetchTelemetry(for: cluster)
            }
        }
        
        var localizedLogs: [String] = []
        // Asynchronously iterate over task responses as they finish executing
        for try await report in group {
            localizedLogs.append(report)
        }
        return localizedLogs
    }
}

Task {
    let manifest = ["Biolume Sub-Station Alpha", "Hydro-Vent Forge", "Trench Node 1544b"]
    print("\n--- INITIATING SYSTEM-WIDE CLUSTER SWEEP ---")
    if let diagnosticLogs = try? await sweepAllClusters(manifest) {
        diagnosticLogs.forEach { print($0) }
    }
}

// Actor (Protecting Shared Mutable State)
actor ReactorCore {
    private var coreTemperature: Double = 180.0
    private var incidentLogs: [String] = []

    func logPlasmaVentEvent(tempIncrease: Double) {
        coreTemperature += tempIncrease
        incidentLogs.append("Plasma vent triggered. Internal temperature spiked by \(tempIncrease)°C.")
    }

    func inspectCoreStatus() -> String {
        if coreTemperature >= 250.0 {
            return "STATUS CRITICAL: Core Temp at \(coreTemperature)°C! Run code 'try? riskyOperation()' immediately!"
        }
        return "STATUS OPTIMAL: Core Temp at \(coreTemperature)°C. Coolant circulation functional."
    }
}

let centralCore = ReactorCore()

// Multiple concurrent tasks can assault the actor without risking race conditions or memory crashes
Task {
    // Accessing an actor's mutable methods outside its scope REQUIRES the await keyword
    await centralCore.logPlasmaVentEvent(tempIncrease: 45.5)
    await centralCore.logPlasmaVentEvent(tempIncrease: 30.2)
    
    let criticalReport = await centralCore.inspectCoreStatus()
    print("\n[CENTRAL ACTOR READOUT] -> \(criticalReport)")
}
