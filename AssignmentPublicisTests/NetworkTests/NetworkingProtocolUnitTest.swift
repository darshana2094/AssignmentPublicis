//
//  UserTest.swift
//  PublicisSapientAssignmentTests
//
//  Created by Darshana Nagekar on 04/01/25.
//

import XCTest
import Combine
@testable import AssignmentPublicis

final class NetworkManagerTests: XCTestCase {
    
    var cancellables: Set<AnyCancellable> = []
    
    //MARK :- Test successful response
    
    func test_SuccessfulRequest() {
        // Given
        let networkManagerStub = NetworkManagerStub(result: successPublisher)
        let endpoint = MockEndPoint()
        
        // When
        networkManagerStub.request(endPoint: endpoint)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail("Expected success, but got error: \(error)")
                }
            }, receiveValue: { (user: User) in
                // Then
                XCTAssertEqual(user.id, 1)
                XCTAssertEqual(user.name, "John Doe")
            })
            .store(in: &cancellables)
    }
    
    //MARK :-  Test server error
    
    func test_ServerError() {
        
        let networkManagerStub = NetworkManagerStub(result: serverErrorPublisher)
        let endpoint = MockEndPoint()
        
        // When
        networkManagerStub.request(endPoint: endpoint)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    XCTFail("Expected error, but got success")
                case .failure(let error):
                    // Then
                    XCTAssertEqual(error as? NetworkingError, NetworkingError.serverError(statusCode: 500))
                }
            }, receiveValue: { (user: User) in
                XCTFail("Expected failure, but got user: \(user)")
            })
            .store(in: &cancellables)
    }
    
    //MARK :-  Test invalid data (decoding error)
    
    func test_DecodingError() {
        
        let networkManagerStub = NetworkManagerStub(result: failurePublisher)
        let endpoint = MockEndPoint()
        
        // When
        networkManagerStub.request(endPoint: endpoint)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    XCTFail("Expected decoding error, but got success")
                case .failure(let error):
                    // Then
                    XCTAssertEqual(error as? NetworkingError, NetworkingError.decodingError)
                }
            }, receiveValue: { (user: User) in
                XCTFail("Expected failure, but got user: \(user)")
            })
            .store(in: &cancellables)
    }
    
    
    //MARK :- Test bad URL response error
    
    func test_BadURLResponse() {
        
        // Given
        let networkManagerStub = NetworkManagerStub(result: badURLPublisher)
        let endpoint = MockEndPoint()
        
        // When
        networkManagerStub.request(endPoint: endpoint)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    XCTFail("Expected bad URL response error, but got success")
                case .failure(let error):
                    // Then
                    XCTAssertEqual(error as? NetworkingError, NetworkingError.badURLResponse)
                }
            }, receiveValue: { (user: User) in
                XCTFail("Expected failure, but got user: \(user)")
            })
            .store(in: &cancellables)
    }
    
    
    //MARK :- Test Unknown Error
    
    func test_UnknownResponse() {
        
        // Given
        let networkManagerStub = NetworkManagerStub(result: unknownPublisher)
        let endpoint = MockEndPoint()
        
        // When
        networkManagerStub.request(endPoint: endpoint)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    XCTFail("Expected Unknown error, but got success")
                case .failure(let error):
                    // Then
                    XCTAssertEqual(error as? NetworkingError, NetworkingError.unknown)
                }
            }, receiveValue: { (user: User) in
                XCTFail("Expected failure, but got user: \(user)")
            })
            .store(in: &cancellables)
    }
}



