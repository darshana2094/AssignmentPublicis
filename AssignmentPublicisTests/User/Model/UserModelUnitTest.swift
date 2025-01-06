//
//  UserModelUnitTes.swift
//  AssignmentPublicisTests
//
//  Created by Darshana Nagekar on 06/01/25.
//

import Foundation
import XCTest
@testable import AssignmentPublicis


class UserModelTests: XCTestCase {
    
    // MARK: - Equatable Tests
    
    func testUserEquality() {
        let address = Address(street: "1234 Elm St", city: "Springfield", zipcode: "12345")
        let company = Company(name: "Acme Corp")
        
        let user1 = User(id: 1, name: "John Doe", email: "johndoe@example.com", address: address, company: company)
        let user2 = User(id: 1, name: "John Doe", email: "johndoe@example.com", address: address, company: company)
        let user3 = User(id: 2, name: "Jane Doe", email: "janedoe@example.com", address: address, company: company)
        
        XCTAssertTrue(user1 == user2, "Users with identical properties should be equal.")
        XCTAssertFalse(user1 == user3, "Users with different properties should not be equal.")
    }
    
    func testAddressEquality() {
        let address1 = Address(street: "1234 Elm St", city: "Springfield", zipcode: "12345")
        let address2 = Address(street: "1234 Elm St", city: "Springfield", zipcode: "12345")
        let address3 = Address(street: "5678 Oak St", city: "Shelbyville", zipcode: "67890")
        
        XCTAssertTrue(address1 == address2)
        XCTAssertFalse(address1 == address3)
    }
    
    func testCompanyEquality() {
        let company1 = Company(name: "Acme Corp")
        let company2 = Company(name: "Acme Corp")
        let company3 = Company(name: "Globex Corp")
        
        XCTAssertTrue(company1 == company2)
        XCTAssertFalse(company1 == company3)
    }
    
    // MARK: - Decodable Tests
    
    func testUserDecoding() {
        // Given
        let jsonData = """
        {
            "id": 1,
            "name": "John Doe",
            "email": "johndoe@example.com",
            "address": {
                "street": "1234 Elm St",
                "city": "Springfield",
                "zipcode": "12345"
            },
            "company": {
                "name": "Acme Corp"
            }
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        
        do {
            // When
            let user = try decoder.decode(User.self, from: jsonData)
            
            // Then
            XCTAssertEqual(user.id, 1)
            XCTAssertEqual(user.name, "John Doe")
            XCTAssertEqual(user.email, "johndoe@example.com")
            XCTAssertEqual(user.address.street, "1234 Elm St")
            XCTAssertEqual(user.address.city, "Springfield")
            XCTAssertEqual(user.address.zipcode, "12345")
            XCTAssertEqual(user.company.name, "Acme Corp")
        } catch {
            XCTFail("User decoding failed with error: \(error)")
        }
    }
    
    func testAddressDecoding() {
        // Given
        let jsonData = """
        {
            "street": "1234 Elm St",
            "city": "Springfield",
            "zipcode": "12345"
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        
        do {
            // When
            let address = try decoder.decode(Address.self, from: jsonData)
            
            // Then
            XCTAssertEqual(address.street, "1234 Elm St")
            XCTAssertEqual(address.city, "Springfield")
            XCTAssertEqual(address.zipcode, "12345")
        } catch {
            XCTFail("Address decoding failed with error: \(error)")
        }
    }
    
    func testCompanyDecoding() {
        // Given
        let jsonData = """
        {
            "name": "Acme Corp"
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        
        do {
            // When: Decoding the Company object
            let company = try decoder.decode(Company.self, from: jsonData)
            
            // Then: Verify the properties are correctly set
            XCTAssertEqual(company.name, "Acme Corp")
        } catch {
            XCTFail("Company decoding failed with error: \(error)")
        }
    }
}
