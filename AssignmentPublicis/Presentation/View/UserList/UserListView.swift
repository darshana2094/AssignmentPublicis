//
//  ContentView.swift
//  PublicisSapientAssignment
//
//  Created by Darshana Nagekar on 03/01/25.
//

import SwiftUI


struct UserListView: View {
    
    //MARK: Properties
    @StateObject var userListViewModel: UserListViewModel
    @State private var showProgressView = true
    
    //MARK: Initializer
    init(usersUseCaseProtocol: UsersUseCaseProtocol) {
        _userListViewModel = StateObject(wrappedValue: UserListViewModel(userUseCase: usersUseCaseProtocol))
    }
    
    var body: some View {
        NavigationStack {
            content
                .navigationTitle(StringConstants.navigationBarTitle)
                .navigationBarTitleDisplayMode(.inline)
                .task {
                    if userListViewModel.isNetworkAvailable {
                        await userListViewModel.getUsers()
                   }
                }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                showProgressView = false
            }
        }
    }
    
    //MARK: Content ViewBuilder
    
    @ViewBuilder private var content: some View {
        if userListViewModel.loadingState.isLoading || showProgressView {
            progressView().accessibilityIdentifier(StringConstants.accessiblityTextForIndicator)
        }else {
            userListView
        }
    }

    
    //MARK: User List View
    
    private var userListView: some View {
        Group {
            if let users = userListViewModel.users {
                if users.isEmpty {
                    contentUnavailableView(
                        title: StringConstants.noUserFoundText,
                        imageName: "person.slash",
                        subTitle: ""
                    )
                } else {
                    List(users, id: \.id) { user in
                        NavigationLink(destination: UserDetailsCard(user: user)) {
                            UserRowItem(user: user)
                        }
                    }
                    .listStyle(.inset)
                    .accessibilityIdentifier(StringConstants.accessiblityTextForLisView)
                }
            } else if userListViewModel.isError {
                contentUnavailableView(title: StringConstants.somethingWentWrongText, imageName: "exclamationmark.circle.fill", subTitle: StringConstants.pleaseTryAgainTexr)
            } else if !userListViewModel.isNetworkAvailable {
                contentUnavailableView(title: StringConstants.noInternetConnectionText, imageName: "wifi.slash", subTitle: StringConstants.checkInternetText)
            }
            
        }
    }
    
    //MARK: Progress View
    
    private func progressView() -> some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .gray))
            .scaleEffect(1.5)
            .padding(20)
    }
    
    //MARK: ContentUnavailableView
    
    private func contentUnavailableView(title: String, imageName: String, subTitle: String) -> some View {
        ContentUnavailableView {
            Label(title, systemImage: imageName)
        } description: {
            Text(subTitle)
        } actions: {
            Button(StringConstants.refreshButtonText) {
                Task {
                    await userListViewModel.getUsers()
                }
            }
        }
    }
}

