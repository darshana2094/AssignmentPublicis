//
//  Untitled.swift
//  AssignmentPublicis
//
//  Created by Darshana Nagekar on 06/01/25.
//

import XCTest
import SwiftUI
import SnapshotTesting
@testable import AssignmentPublicis

final class UserRowItemViewSnapshotTest: XCTestCase {
    
    var userItemRow:UserRowItem!

    override func setUpWithError() throws {
        
        userItemRow = UserRowItem(user:User(
            id:1,
            name: "John Doe",
            email: "john.doe@example.com",
            address: Address(
                street: "123 Main St",
                city: "Springfield",
                zipcode: "12345"
            ),
            company: Company(name: "Acme Corp")
        ))
    }
    
    override func tearDownWithError() throws {
        userItemRow = nil
    }
    
    func testUserListViewSnapShot() {

        let view: UIView = UIHostingController(rootView: userItemRow).view
        
        assertSnapshot(
            of: view,
          as: .image(size: view.intrinsicContentSize)
        )
    }
}

