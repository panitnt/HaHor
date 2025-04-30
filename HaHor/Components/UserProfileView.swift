//
//  UserProfileView.swift
//  HaHor
//
//  Created by bell on 21/4/2568 BE.
//

import SwiftUI

@MainActor
final class UserProfileViewModel: ObservableObject {
    
    static let shared = UserProfileViewModel() // using singleton
    
    @Published var email: String = ""
    @Published var username: String = ""
    
    @Published private(set) var authUser: AuthDataResultModel? = nil
    @Published private(set) var user: DBUser? = nil
    
    @Published var favoriteDorms: [Dorm] = []
    @Published var isFavoriteDormsLoaded = false
    @Published var dorms: [Dorm] = []
    @Published var isDormLoading = false
    @Published var dormLoadError: String?

    func fetchDormsIfNeeded() async {
        if dorms.isEmpty {
            isDormLoading = true
            dormLoadError = nil
            do {
                dorms = try await DormManager.shared.fetchAllDorms()
            } catch {
                dormLoadError = error.localizedDescription
            }
            isDormLoading = false
        }
    }

    
    
    func loadUser() {
        Task {
            do {
                if let authDataResult = try AuthnticationManager.shared.getAuthenticatedUser() {
                    self.authUser = authDataResult
                    self.email = authDataResult.email ?? "No Email"
                    self.username = authDataResult.username ?? "No Username"
                    
                    let userData = try await UserManager.shared.getUser(userId: authDataResult.uid)
                    self.user = userData
                    
                    let favoriteIDs = userData.favorite
                    var dorms: [Dorm] = []
                    
                    for id in favoriteIDs {
                        if let dorm = try? await DormManager.shared.fetchDorm(by: id) {
                            dorms.append(dorm)
                        }
                    }
                    
                    self.favoriteDorms = dorms
                    self.isFavoriteDormsLoaded = true
                    
                }
            } catch {
                print("Failed to load user: \(error.localizedDescription)")
            }
        }
    }
}


struct UserProfileView: View {
    //    @StateObject private var viewModel = UserProfileViewModel.shared
    @EnvironmentObject var viewModel: UserProfileViewModel
    
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
