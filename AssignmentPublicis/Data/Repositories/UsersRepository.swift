//
//  UsersRepository.swift
//  PublicisSapientAssignment
//
//  Created by Darshana Nagekar on 04/01/25.
//

import Foundation
import Combine

// Protocol that defines the method for a user repository.
// This allows for fetching all users as a list of `User` objects.
protocol UserRepositoryProtocol {
    
    // Asynchronously fetches all users and returns a publisher that emits an array of `User` objects or an error.
    func fetchAllUsers() async -> AnyPublisher<[User], Error>
}

// Implementation of the UserRepositoryProtocol.
final class UserRepositoryImpl: UserRepositoryProtocol {
    
    //MARK: Properties
    // Dependency on a UsersService that handles the actual user-fetching.
    private var usersService: UsersService
        
    //MARK: Initializer
    // Initializer that injects the required UsersService dependency(constructor DI).
    init(usersService: UsersService) {
        self.usersService = usersService
    }
    
    //MARK: Method to fetch all users
    // Asynchronously fetches all users by delegating the call to usersService.
    // Returns a publisher that emits an array of User objects or an error.
    func fetchAllUsers() async -> AnyPublisher<[User], any Error> {
        // Calls the fetchUsers method on usersService and returns its publisher.
        return await usersService.fetchUsers()
    }
}

