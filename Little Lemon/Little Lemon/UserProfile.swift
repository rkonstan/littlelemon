//
//  UserProfile.swift
//  Little Lemon
//
//  Created by Rick Konstan on 19/3/2024.
//

import SwiftUI

struct UserProfile: View {
    @Environment(\.presentationMode) var presentation
    @State var firstName = UserDefaults.standard.string(forKey: "firstName")
    @State var lastName = UserDefaults.standard.string(forKey: "lastName")
    @State var email = UserDefaults.standard.string(forKey: "email")
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Personal Information")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .fontWeight(.semibold)
                .padding(.bottom, 20)
            Image("Profile")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150, alignment: .center)
                .padding(.bottom, 30)
            Group {
                Text("First name is")
                    .font(.callout)
                Text(firstName ?? "")
                    .font(.headline)
                    .padding().frame(maxWidth: .infinity)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 4))
                Text("Last name is")
                    .font(.callout)
                Text(lastName ?? "")
                    .font(.headline)
                    .padding().frame(maxWidth: .infinity)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 4))
                Text("Email is")
                    .font(.callout)
                Text(email ?? "")
                    .font(.headline)
                    .padding().frame(maxWidth: .infinity)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 4))
            }
            .font(.headline)
            Spacer()
            Button("Log out") {
                UserDefaults.standard.set(false, forKey: "isLoggedIn")
                self.presentation.wrappedValue.dismiss()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color("Logout button"))
            .cornerRadius(5)
            .foregroundStyle(.black)
            .font(.headline)
        }
        .padding()
    }
}

#Preview {
    UserProfile()
}
