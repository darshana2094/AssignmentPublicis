//
//  UserDetailsCard.swift
//  PublicisSapientAssignment
//
//  Created by Darshana Nagekar on 04/01/25.
//

import SwiftUI

struct UserDetailsCard: View {
    
    let user: User
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(radius: 10)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                )
            
            VStack(alignment: .leading, spacing: 10) {
                detailRow(title: StringConstants.nameText, value: user.name)
                detailRow(title: StringConstants.emailText, value: user.email)
                detailRow(title: StringConstants.addressText, value: "\(user.address.street), \(user.address.city), \(user.address.zipcode)")
                detailRow(title: StringConstants.companyText, value: user.company.name)
            }
            .padding()
        }
        .frame(width: 350, height: 200)
    }
    
    private func detailRow(title: String, value: String) -> some View {
        HStack {
            Text("\(title):")
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(.black)
            
            Text(value)
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.leading)
                .minimumScaleFactor(0.8)
                .lineLimit(nil)
        }
    }
}

#Preview {
    UserDetailsCard(user: User(
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



