//
//  UsersService.swift
//  PublicisSapientAssignment
//
//  Created by Darshana Nagekar on 04/01/25.
//

import Foundation
import Combine


/// A service responsible for fetching user-related data from the network.
///
/// This class interacts with the networking layer to retrieve user data.
/// It acts as a bridge between the repository and the networking components.
final class UsersService {
    
    // MARK: - Properties
    
    /// The network manager responsible for executing network requests.
    private var networkManager: NetworkingProtocol
    
    // MARK: - Initializer
    
    // Initializes a new instance of UsersService .
    //
    // - Parameter networkManager: An instance conforming to NetworkingProtocol used for making network requests.
    init(networkManager: NetworkingProtocol) {
        self.networkManager = networkManager
    }
    
    // MARK: - Methods
    
    // Fetches a list of users from the server.
    //
    // - Returns: A publisher that emits an array of User objects on success or an Error on failure.
    // The publisher is delivered on the main thread.
    func fetchUsers() async -> AnyPublisher<[User], Error> {
        networkManager.request(endPoint: UserApi.users)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}


