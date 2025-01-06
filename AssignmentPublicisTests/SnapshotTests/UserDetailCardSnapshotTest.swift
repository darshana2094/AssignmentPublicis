//
//  UserDetailCardTest.swift
//  AssignmentPublicisTests
//
//  Created by Darshana Nagekar on 05/01/25.
//


import XCTest
import SnapshotTesting
import SwiftUI
@testable import AssignmentPublicis


final class UserDetailsCardSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }

    func testUserDetailsCardRendering() {
       
        let user = User(
            id:1,
            name: "John Doe",
            email: "john.doe@example.com",
            address: Address(
                street: "123 Main St",
                city: "Springfield",
                zipcode: "12345"
            ),
            company: Company(name: "Acme Corp")
        )
        
        let view = UserDetailsCard(user: user).frame(width: 350, height: 200)
        
        let viewController: UIView = UIHostingController(rootView: view).view
        
        assertSnapshot(of: viewController, as: .image)
    }
}
