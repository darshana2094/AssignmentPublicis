//
//  FakeUser.swift
//  PublicisSapientAssignmentTests
//
//  Created by Darshana Nagekar on 05/01/25.
//

import Combine
import SwiftUI


@testable import AssignmentPublicis

// Successful mock response data
let mockUserData = """
{
    "id": 1,
    "name": "John Doe",
    "email": "johndoe@example.com",
    "address": {
        "street": "123 Main St",
        "city": "Springfield",
        "zipcode": "12345"
    },
    "company": {
        "name": "Acme Corporation"
    }
}
""".data(using: .utf8)!

// Decoding failure mock data (wrong structure)
let mockInvalidUserData = """
{
    "_id": 10,
    "name": "John Doe",
    "email": "johndoe@example.com",
    "address": {
        "street": "123 Main St",
        "city": "Springfield",
        "zipcode": "12345"
    },
    "company": {
        "name": "Acme Corporation"
    }
}
""".data(using: .utf8)!


// Mock URL Response with successful data
let successPublisher = Just(mockUserData)
    .setFailureType(to: NetworkingError.self)
    .eraseToAnyPublisher()

// Mock error publisher for a server error (500)
let serverErrorPublisher = Fail<Data, NetworkingError>(error: NetworkingError.serverError(statusCode: 500))
    .eraseToAnyPublisher()

// Mock URL response with invalid data (decoding failure)
let failurePublisher = Just(mockInvalidUserData)
    .setFailureType(to: NetworkingError.self)
    .eraseToAnyPublisher()

// Mock error response with bad URL Response
let badURLPublisher = Fail<Data, NetworkingError>(error: NetworkingError.badURLResponse)
    .eraseToAnyPublisher()

// Mock unkown error
let unknownPublisher = Fail<Data, NetworkingError>(error: NetworkingError.unknown)
    .eraseToAnyPublisher()



