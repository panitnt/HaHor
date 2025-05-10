//
//  UserView.swift
//  HaHor
//
//  Created by bell on 21/4/2568 BE.
//

import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject{
    func signOut() throws{
        try AuthnticationManager.shared.signOut()
    }
}



struct UserView: View {
    
    @StateObject private var viewModel = SettingsViewModel()
    
    @Binding var showSignInView: Bool
    
    @EnvironmentObject var userVM: UserProfileViewModel
    
    //    @State private var favoriteDorms: [Dorm] = []
    
    var body: some View {
        ZStack{
            Color(.systemGray6) // Light gray background
                .ignoresSafeArea() // Make it fill full screen
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    
                    UserProfileView()
                    
                    Divider()
                    
                    // Favorites Title
                    Text("Favorites")
                        .font(.title2)
                        .bold()
                    
                    // Favorite Cards
                    if userVM.favoriteDorms.isEmpty {
                        Text("No favorites found.")
                            .foregroundColor(.gray)
                    } else {
                        ForEach(userVM.favoriteDorms, id: \.id) { dorm in
                            
                            NavigationLink {
                                DormDetailView(dorm: dorm)
                            } label: {
                                CardView(
                                    imageName: dorm.name,
                                    title: dorm.name,
                                    rating: dorm.avg_review,
                                    priceRange: dorm.price,
                                    isFavorite: true,
                                    onFavoriteToggle: {
                                        userVM.removeFavorite(dormId: dorm.id)
                                    }
                                )

                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    
                    
                    Divider()
                    
                    VStack(spacing: 0) {
                        Button("Log out") {
                            Task{
                                do{
                                    try viewModel.signOut()
                                    showSignInView = true
                                }catch{
                                    print(error)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                    }
                }
                .padding()
                
            } // end scrollView
        }
    }
}


#Preview {
    UserView(showSignInView: .constant(false))
}
