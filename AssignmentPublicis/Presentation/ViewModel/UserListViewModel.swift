//
//  UserListViewModel.swift
//  PublicisSapientAssignment
//
//  Created by Darshana Nagekar on 03/01/25.
//

import SwiftUI
import Combine


/// A `@MainActor` view model responsible for managing the user list and handling associated business logic.
///
/// This class is designed to be used in SwiftUI views as an `ObservableObject`.
/// It interacts with the use case layer to fetch user data and provides state information to the UI.
@MainActor
final class UserListViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    /// The list of users fetched from the use case.
    @Published var users: [User]?
    
    /// The loading state, encapsulating information about the current loading status, errors, and success.
    @Published var loadingState = ErrorLoadingState()
    
    /// Indicates whether the network is available.
    @Published var isNetworkAvailable: Bool = true
    
    /// Indicates whether an error has occurred.
    @Published var isError: Bool = false
    
    // MARK: - Private Properties
    
    /// The use case responsible for fetching users.
    private var userUseCase: UsersUseCaseProtocol
    
    /// A shared instance of the network monitor for tracking network connectivity.
    private var networkMonitor = NetworkMonitor.shared
    
    /// A set of cancellables for managing Combine subscriptions related to login responses.
    private var loginSubscription = Set<AnyCancellable>()
    
    /// A set of cancellables for managing Combine subscriptions related to network monitoring.
    private var networkMonitorSubscription = Set<AnyCancellable>()
    
    // MARK: - Initializer
    
    /// Initializes a new instance of `UserListViewModel`.
    ///
    /// - Parameter userUseCase: An instance conforming to `UsersUseCaseProtocol` for handling user fetching logic.
    init(userUseCase: UsersUseCaseProtocol) {
        self.userUseCase = userUseCase
        
        // Monitor network connectivity and update the `isNetworkAvailable` property.
        networkMonitor.$isConnected
            .sink { [weak self] isConnected in
                self?.isNetworkAvailable = isConnected
            }
            .store(in: &networkMonitorSubscription)
    }
    
    // MARK: - Methods
    
    /// Fetches the list of users from the use case.
    ///
    /// This method updates the `loadingState` to reflect the current status of the request.
    /// It checks for network connectivity before attempting to fetch users and handles
    /// both success and failure scenarios.
    func getUsers() async {
        self.loadingState.updateLoadingState(isLoading: true, isSuccess: false)
        
        if isNetworkAvailable {
            isError = true
        }
        
        await userUseCase.execute()
            .sink { [weak self] completion in
                self?.handleCompletion(completion)
            } receiveValue: { [weak self] returnedLoginResponse in
                self?.handleLoginResponse(returnedLoginResponse)
            }
            .store(in: &loginSubscription)
    }
    
    /// Handles the completion of the Combine publisher from the use case.
    ///
    /// - Parameter completion: A `Subscribers.Completion` instance indicating success or failure.
    func handleCompletion(_ completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            self.loadingState.updateLoadingState(isLoading: false, isSuccess: true)
        case .failure(let error):
            loadingState.updateLoadingState(isLoading: false, errorMessage: error.localizedDescription, isSuccess: false)
        }
    }
    
    /// Handles the response containing a list of users.
    ///
    /// - Parameter response: An array of `User` objects fetched from the use case.
    private func handleLoginResponse(_ response: [User]) {
        self.users = response
        resetLoadingState()
    }
    
    /// Resets the loading state to its default values.
    func resetLoadingState() {
        loadingState.updateLoadingState(isLoading: false, errorMessage: nil, isSuccess: false)
    }
}
