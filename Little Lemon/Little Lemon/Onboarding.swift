//
//  Onboarding.swift
//  Little Lemon
//
//  Created by Rick Konstan on 19/3/2024.
//

import SwiftUI

let keyFirstName = "firstName"
let keyLastName = "lastName"
let keyEmail = "email"
let keyIsLoggedIn = "isLoggedIn"

struct Onboarding: View {
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    @State var isLoggedIn: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink(destination: Home(), isActive: $isLoggedIn) {
                    EmptyView()
                }
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(alignment: .center)
                    Spacer()
                Text("Register with Little Lemon Restaurant!")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                Spacer()
                Group {
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                    TextField("Email", text: $email)
                }
                .padding()
                .background(Color.gray.opacity(0.2).cornerRadius(10))
                .foregroundColor(.black)
                .font(.headline)
                
                Button("Register".uppercased()) {
                    if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty {
                        UserDefaults.standard.set(firstName, forKey: keyFirstName)
                        UserDefaults.standard.set(lastName, forKey: keyLastName)
                        UserDefaults.standard.set(email, forKey: keyEmail)
                        UserDefaults.standard.set(true, forKey: keyIsLoggedIn)
                        isLoggedIn = true
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color("Logout button"))
                .cornerRadius(10)
                .foregroundColor(.white)
                .font(.headline)
                .padding(.top, 50)
            }
            .onAppear() {
                if (UserDefaults.standard.bool(forKey: keyIsLoggedIn)) {
                    isLoggedIn = true
                }
            }
        }
    }
}

#Preview {
    Onboarding()
}
