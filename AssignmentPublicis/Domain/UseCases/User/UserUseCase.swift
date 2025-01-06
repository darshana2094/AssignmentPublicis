//
//  UserUseCase.swift
//  PublicisSapientAssignment
//
//  Created by Darshana Nagekar on 03/01/25.
//

import Foundation
import Combine

/// A protocol defining the use case for fetching users.
///
/// This protocol abstracts the business logic of fetching user data.
/// It ensures that the implementation can be easily mocked or replaced.
protocol UsersUseCaseProtocol {
    
    /// Executes the use case to fetch a list of users.
    ///
    /// - Returns: A publisher that emits an array of `User` objects on success or an `Error` on failure.
    func execute() async -> AnyPublisher<[User], Error>
}

/// A concrete implementation of `UsersUseCaseProtocol`.
///
/// This class handles the business logic of fetching users by interacting
/// with the repository layer.
final class UsersUseCase: UsersUseCaseProtocol {
    
    // MARK: - Properties
    
    /// The repository responsible for fetching user data.
    private let userRepository: UserRepositoryProtocol
    
    // MARK: - Initializer
    
    /// Initializes a new instance of `UsersUseCase`.
    ///
    /// - Parameter userRepository: An instance conforming to `UserRepositoryProtocol`
    ///   used to fetch user data from a data source.
    init(userRepository: UserRepositoryProtocol) {
        self.userRepository = userRepository
    }
    
    // MARK: - Methods
    
    /// Executes the use case to fetch a list of users.
    ///
    /// This method interacts with the repository to fetch user data
    /// and returns a publisher that emits the results.
    ///
    /// - Returns: A publisher that emits an array of `User` objects on success or an `Error` on failure.
    func execute() async -> AnyPublisher<[User], Error> {
        return await userRepository.fetchAllUsers()
    }
}

