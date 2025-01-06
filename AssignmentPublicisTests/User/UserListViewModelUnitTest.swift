//
//  UserListTest.swift
//  AssignmentPublicisTests
//
//  Created by Darshana Nagekar on 05/01/25.
//

import XCTest
import Combine
@testable import AssignmentPublicis


@MainActor
final class UserListViewModelTests: XCTestCase {
    
    var viewModel: UserListViewModel!
    var mockUserUseCase: MockUsersUseCase!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        cancellables = []
    }
    
    override func tearDown() {
        cancellables = nil
        viewModel = nil
        mockUserUseCase = nil
        super.tearDown()
    }
    
    func test_InitialState() {
        mockUserUseCase = MockUsersUseCase()
        viewModel = UserListViewModel(userUseCase: mockUserUseCase)
        
        XCTAssertNil(viewModel.users)
        XCTAssertEqual(viewModel.loadingState.isLoading, false)
        XCTAssertEqual(viewModel.loadingState.isSuccess, false)
        XCTAssertNil(viewModel.loadingState.errorMessage)
    }


    func test_GetUsers_Success() async {
        mockUserUseCase = MockUsersUseCase()
        let mockUsers = [
            User(id: 1, name: "John Doe", email: "johndoe@example.com", address: Address(street: "123 Main St", city: "New York", zipcode: "10001"), company: Company(name: "Apple")),
            User(id: 2, name: "Jane Smith", email: "janesmith@example.com", address: Address(street: "456 Elm St", city: "San Francisco", zipcode: "94101"), company: Company(name: "Google"))
        ]
        mockUserUseCase.result = .success(mockUsers)
        viewModel = UserListViewModel(userUseCase: mockUserUseCase)
    
            await viewModel.getUsers()
            
            XCTAssertEqual(viewModel.users, mockUsers)
            XCTAssertEqual(viewModel.loadingState.isLoading, false)
            XCTAssertEqual(viewModel.loadingState.isSuccess, true)
            XCTAssertNil(viewModel.loadingState.errorMessage)
    }
    
    func test_GetUsers_Failure() async {
        mockUserUseCase = MockUsersUseCase()
        let mockError = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Network error"])
        mockUserUseCase.result = .failure(mockError)
        viewModel = UserListViewModel(userUseCase: mockUserUseCase)

            await viewModel.getUsers()
            
            XCTAssertNil(viewModel.users)
            XCTAssertEqual(viewModel.loadingState.isLoading, false)
            XCTAssertEqual(viewModel.loadingState.isSuccess, false)
            XCTAssertEqual(viewModel.loadingState.errorMessage, mockError.localizedDescription)
    }
    
    func test_ResetLoadingState() {
        mockUserUseCase = MockUsersUseCase()
        viewModel = UserListViewModel(userUseCase: mockUserUseCase)
        
        viewModel.loadingState.updateLoadingState(isLoading: true, isSuccess: false)
        
        XCTAssertEqual(viewModel.loadingState.isLoading, true)
        
        viewModel.resetLoadingState()
        
        XCTAssertEqual(viewModel.loadingState.isLoading, false)
        XCTAssertEqual(viewModel.loadingState.isSuccess, false)
        XCTAssertNil(viewModel.loadingState.errorMessage)
    }
}
