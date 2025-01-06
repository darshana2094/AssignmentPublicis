//
//  File.swift
//  AssignmentPublicisTests
//
//  Created by Darshana Nagekar on 06/01/25.
//

import XCTest
import Combine
@testable import AssignmentPublicis

final class MockUsersUseCase: UsersUseCaseProtocol {
    var result: Result<[User], Error> = .success([])
    func execute() async -> AnyPublisher<[User], Error> {
            switch result {
            case .success(let users):
                return Just(users)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            case .failure(let error):
                return Fail(error: error)
                    .eraseToAnyPublisher()
            }
        }
}

//final class MockUsersUseCase: UsersUseCaseProtocol {
//    var shouldReturnError = false
//    var users: [User] = []
//
//    func execute() -> AnyPublisher<[User], Error> {
//        if shouldReturnError {
//            return Fail(error: NSError(domain: "TestError", code: 1, userInfo: nil))
//                .eraseToAnyPublisher()
//        } else {
//            return Just(users)
//                .setFailureType(to: Error.self)
//                .eraseToAnyPublisher()
//        }
//    }
//}
//
