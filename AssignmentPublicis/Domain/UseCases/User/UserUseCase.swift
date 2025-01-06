//
//  UserUseCase.swift
//  PublicisSapientAssignment
//
//  Created by Darshana Nagekar on 03/01/25.
//

import Foundation
import Combine

protocol UsersUseCaseProtocol {
    func execute() async -> AnyPublisher<[User], Error>
}

final class UsersUseCase: UsersUseCaseProtocol {
    
    private let userRepository: UserRepositoryProtocol
    
    init(userRepository: UserRepositoryProtocol) {
        self.userRepository = userRepository
    }
    
    func execute() async  -> AnyPublisher<[User],  Error> {
        return await userRepository.fetchAllUsers()
    }
}

