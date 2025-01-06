//
//  MockNetworkMonitor.swift
//  AssignmentPublicis
//
//  Created by Darshana Nagekar on 06/01/25.
//

import XCTest
import Combine
@testable import AssignmentPublicis


class MockNetworkMonitor: NetworkMonitorProtocol {
    
    @Published  var isConnected = true

    var isConnectedPublisher: Published<Bool>.Publisher { $isConnected }
    
    func simulateNetworkChange(isConnected: Bool) {
        self.isConnected = isConnected
    }
}
