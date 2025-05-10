//
//  HomeView.swift
//  HaHor
//
//  Created by bell on 21/4/2568 BE.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedTab = 0
    
    @State private var showSignInView: Bool = false
    
    @StateObject private var viewModel = UserProfileViewModel.shared
    
    var body: some View {
        ZStack{
            NavigationStack{
                VStack (spacing: 0){
                    HeaderView(title: headerTitle(for: selectedTab))
                    
                    Group {
                        switch selectedTab {
                        case 0:
                            MapView()
                        case 1:
                            SortView()
                        case 2:
                            UserView(showSignInView: $showSignInView)
                        default:
                            EmptyView()
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    BottomNavBarView(selectedTab: $selectedTab)
                }
                //                .edgesIgnoringSafeArea(.bottom)
            }
        }.onAppear {
            Task {
                let authUser = try? AuthnticationManager.shared.getAuthenticatedUser()
                self.showSignInView = authUser == nil
                
                
                if !viewModel.isFavoriteDormsLoaded {
                    viewModel.loadUser()
                }
                
                if !viewModel.isDormLoading{
                    await viewModel.fetchDormsIfNeeded()
                }
            }
        }
        .fullScreenCover(isPresented: $showSignInView){
            NavigationStack{
                AuthenticationView(showSignInView: $showSignInView)
            }
        }
        .environmentObject(viewModel) // inject to all child views
//        .environmentObject(UserProfileViewModel.shared)
        
    }
    func headerTitle(for index: Int) -> String {
        switch index {
        case 0: return "Find Match Dorm"
        case 1: return "Sort Options"
        case 2: return "User Profile"
        default: return ""
        }
    }
}

#Preview {
    HomeView()
}
