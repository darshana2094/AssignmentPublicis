//
//  Untitled.swift
//  PublicisSapientAssignment
//
//  Created by Darshana Nagekar on 03/01/25.
//

import Foundation

// MARK: - User
struct User: Decodable,Identifiable,Equatable {
    let id: Int
    let name, email: String
    let address: Address
    let company: Company
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.email == rhs.email && lhs.address == rhs.address && lhs.company == rhs.company
       }
}

// MARK: - Address
struct Address: Decodable,Equatable {
    let street, city, zipcode: String
}

// MARK: - Company
struct Company: Decodable,Equatable {
    let name: String
}

