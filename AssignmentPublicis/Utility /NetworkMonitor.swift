//
//  NetworkMonitor.swift
//  AssignmentPublicis
//
//  Created by Darshana Nagekar on 06/01/25.
//

import Network
import Combine

/// A protocol defining the interface for network monitoring.
///
/// This protocol provides properties for checking network connectivity
/// and observing changes to the connectivity status.
protocol NetworkMonitorProtocol {
    
    /// A Boolean value indicating whether the device is connected to the network.
    var isConnected: Bool { get }
    
    /// A publisher that emits connectivity status updates.
    var isConnectedPublisher: Published<Bool>.Publisher { get }
}

/// A class for monitoring network connectivity using `NWPathMonitor`.
///
/// This class observes changes in network status and publishes updates to
/// subscribers using Combine. It is a singleton and conforms to `NetworkMonitorProtocol`
/// and `ObservableObject` to integrate seamlessly with SwiftUI.
final class NetworkMonitor: NetworkMonitorProtocol, ObservableObject {
    
    // MARK: - Published Properties
    
    /// A Boolean value indicating whether the device is currently connected to the network.
    @Published var isConnected: Bool = true
    
    /// A publisher that emits changes to the network connectivity status.
    var isConnectedPublisher: Published<Bool>.Publisher { $isConnected }
    
    // MARK: - Singleton Instance
    
    /// The shared singleton instance of `NetworkMonitor`.
    static let shared = NetworkMonitor()
    
    // MARK: - Private Properties
    
    /// The underlying network path monitor from `Network`.
    private var monitor: NWPathMonitor
    
    /// The dispatch queue used for monitoring network status changes.
    private var queue: DispatchQueue
    
    // MARK: - Initializer
    
    /// Initializes a new instance of `NetworkMonitor`.
    ///
    /// This initializer sets up the network monitor to observe changes in connectivity
    /// and updates the `isConnected` property accordingly. Monitoring starts immediately
    /// on a background queue.
    private init() {
        monitor = NWPathMonitor()
        queue = DispatchQueue(label: "NetworkMonitorQueue")
        
        // Start monitoring network changes
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
            }
        }
        
        monitor.start(queue: queue)
    }
    
    // MARK: - Deinitializer
    
    /// Stops the network monitor when the instance is deallocated.
    deinit {
        monitor.cancel()
    }
}
