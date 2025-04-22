//
//  UserProfileView.swift
//  HaHor
//
//  Created by bell on 21/4/2568 BE.
//

import SwiftUI

@MainActor
final class UserProfileViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var username: String = ""
    
    func loadUser() {
        do {
            if let user = try AuthnticationManager.shared.getAuthenticatedUser() {
                self.email = user.email ?? "No Email"
                self.username = user.username ?? "No Username"
            }
        } catch {
            print("Failed to load user: \(error.localizedDescription)")
        }
    }
}


struct UserProfileView: View {
    @StateObject private var viewModel = UserProfileViewModel()
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Image(systemName: "person.circle")
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundColor(.black)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(viewModel.username)
                    .font(.title2)
                    .bold()
                
                Text(viewModel.email)
                    .foregroundColor(.blue)
                
            }
        }
        //        .padding()
        .onAppear {
            viewModel.loadUser()
        }
    }
}


#Preview {
    UserProfileView()
}
