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
    
    var body: some View {
        ZStack{
            Color(.systemGray6) // Light gray background
                .ignoresSafeArea() // Make it fill full screen
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    
                    // Profile Section
//                    HStack(alignment: .center, spacing: 16) {
//                        Image(systemName: "person.circle")
//                            .resizable()
//                            .frame(width: 60, height: 60)
//                            .foregroundColor(.black)
//                        
//                        VStack(alignment: .leading, spacing: 4) {
//                            Text("I Love KU 1234")
//                                .font(.headline)
//                            Text("Email@ku.th")
//                                .font(.subheadline)
//                                .foregroundColor(.gray)
//                        }
//                    }
                    UserProfileView()
                    
                    Divider()
                    
                    // Favorites Title
                    Text("Favorites")
                        .font(.title2)
                        .bold()
                    
                    // Favorite Cards
                    CardView(
                        imageName: "pixels",
                        title: "The Pixels at Kaset",
                        rating: "5.0 (2)",
                        priceRange: "6,000 - 8,000",
                        isFavorite: true
                    )
                    
                    CardView(
                        imageName: "chapter",
                        title: "Chapter One The Campus Kaset",
                        rating: "4.9 (23)",
                        priceRange: "9,000 - 12,000",
                        isFavorite: true
                    )
                    
                    CardView(
                        imageName: "chapter",
                        title: "Chapter One The Campus Kaset",
                        rating: "4.9 (23)",
                        priceRange: "9,000 - 12,000",
                        isFavorite: true
                    )
                    
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
