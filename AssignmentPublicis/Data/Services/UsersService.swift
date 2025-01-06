//
//  UsersService.swift
//  PublicisSapientAssignment
//
//  Created by Darshana Nagekar on 04/01/25.
//

import Foundation
import Combine


final class UsersService {
    
    private var networkManager: NetworkingProtocol
    
    init(networkManager: NetworkingProtocol) {
        self.networkManager = networkManager
    }
    
    func fetchUsers() async -> AnyPublisher<[User], Error> {
        networkManager.request(endPoint: UserApi.users)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}



