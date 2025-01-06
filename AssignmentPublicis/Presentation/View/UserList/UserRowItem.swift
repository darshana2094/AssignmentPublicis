//
//  UserRowItem.swift
//  PublicisSapientAssignment
//
//  Created by Darshana Nagekar on 03/01/25.
//

import SwiftUI

struct UserRowItem: View {
    
    let user:User
    
 
    var body: some View {
        HStack {
            VStack(alignment: .leading,spacing:5) {
                Text("# \(user.id) \(user.name)")
        
                HStack(spacing:0) {
                    Image(systemName: "envelope.fill")
                        .foregroundColor(.red)
                    Text(user.email).font(.subheadline).foregroundColor(.gray)
                }
            }
            Spacer()
           
            HStack(spacing:0) {
                Image(systemName: "mappin")
                    .foregroundColor(.orange)
                Text(user.address.city)
                    .font(.footnote)
            }
           
        }.accessibilityIdentifier("UserCell-\(user.id)")
    }
}

#Preview {
    UserRowItem(user:User(
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
