//
//  UsersRepository.swift
//  PublicisSapientAssignment
//
//  Created by Darshana Nagekar on 04/01/25.
//

import Foundation
import Combine

protocol UserRepositoryProtocol {
    func fetchAllUsers() async  -> AnyPublisher<[User], Error>
}

final class UserRepositoryImpl: UserRepositoryProtocol {
    private var usersService: UsersService
    
    init(usersService: UsersService) {
        self.usersService = usersService
    }
    
    func fetchAllUsers()  async -> AnyPublisher<[User], any Error> {
        return await usersService.fetchUsers()
    }
}
