//
//  AssignmentPublicisApp.swift
//  AssignmentPublicis
//
//  Created by Darshana Nagekar on 05/01/25.
//

import SwiftUI

@main
struct AssignmentPublicisApp: App {
    
    init() {
//        _ = NetworkMonitor.shared.$isConnected.sink { isConnected in
//        }

    }
    var body: some Scene {
        WindowGroup {
            UserListView(usersUseCaseProtocol: UsersUseCase(userRepository: UserRepositoryImpl(usersService: UsersService(networkManager: NetworkManager()))))
        }
    }
}
