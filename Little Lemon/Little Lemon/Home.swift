//
//  Home.swift
//  Little Lemon
//
//  Created by Rick Konstan on 19/3/2024.
//

import SwiftUI

struct Home: View {
    
    var body: some View {
        TabView() {
            let menuView = Menu()
            menuView.tabItem {
                Label("Menu", systemImage: "list.dash")
            }
            let userProfileView = UserProfile()
            userProfileView.tabItem {
                Label("Profile", systemImage: "square.and.pencil")
            }
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    Home()
}
