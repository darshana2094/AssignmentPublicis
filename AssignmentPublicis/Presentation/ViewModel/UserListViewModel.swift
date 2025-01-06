//
//  UserListViewModel.swift
//  PublicisSapientAssignment
//
//  Created by Darshana Nagekar on 03/01/25.
//

import SwiftUI
import Combine

@MainActor
final class UserListViewModel: ObservableObject {
    
    @Published var users: [User]?
    @Published var loadingState = ErrorLoadingState()
    @Published var isNetworkAvailable: Bool = true
    @Published var isError: Bool = false
    
    private var userUseCase: UsersUseCaseProtocol
    private var networkMonitor = NetworkMonitor.shared
    private var loginSubscription = Set<AnyCancellable>()
    private var networkMonitorSubscription = Set<AnyCancellable>()

    
    init(userUseCase: UsersUseCaseProtocol) {
        
        self.userUseCase = userUseCase
        
        networkMonitor.$isConnected.sink { [weak self] isConnected in
            self?.isNetworkAvailable = isConnected

        }
        .store(in: &networkMonitorSubscription)
    }
    
    func getUsers() async {
    
        
        self.loadingState.updateLoadingState(isLoading: true, isSuccess: false)
        
        if isNetworkAvailable  {
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
    
    
    func handleCompletion(_ completion: Subscribers.Completion<Error>) {
        
        switch completion {
        case .finished:
            self.loadingState.updateLoadingState(isLoading: false, isSuccess: true)
            
        case .failure(let error):
            
            loadingState.updateLoadingState(isLoading: false, errorMessage: error.localizedDescription, isSuccess: false)
        }
    }
    
    private func handleLoginResponse(_ response: [User]) {
        self.users = response
        resetLoadingState()
    }
    
    func resetLoadingState() {
        loadingState.updateLoadingState(isLoading: false, errorMessage: nil, isSuccess: false)
    }
}
