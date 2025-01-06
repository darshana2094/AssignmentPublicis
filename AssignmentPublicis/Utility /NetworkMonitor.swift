//
//  NetworkMonitor.swift
//  AssignmentPublicis
//
//  Created by Darshana Nagekar on 06/01/25.
//

import Network
import Combine

protocol NetworkMonitorProtocol {
    var isConnected: Bool { get }
    var isConnectedPublisher: Published<Bool>.Publisher { get }
}
 class NetworkMonitor: NetworkMonitorProtocol,ObservableObject {
    private var monitor: NWPathMonitor
    private var queue: DispatchQueue
    
     @Published var isConnected: Bool = true
    var isConnectedPublisher: Published<Bool>.Publisher { $isConnected }

    static let shared = NetworkMonitor()
    
    init() {
        monitor = NWPathMonitor()
        queue = DispatchQueue(label: "NetworkMonitorQueue")
        
        // Start monitoring network changes
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                // Check if connected to WiFi or Cellular
                self.isConnected = path.status == .satisfied
            }
        }
        
        monitor.start(queue: queue)
    }
    
    deinit {
        monitor.cancel()
    }
}
