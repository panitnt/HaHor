import SwiftUI

//
//  DormListView.swift
//  HaHor
//
//  Created by bell on 30/4/2568 BE.
//

import SwiftUI

struct SortView: View {
    @State private var searchText: String = ""
    @State private var minPrice: String = ""
    @State private var maxPrice: String = ""
    @State private var selectedTab: Int = 1 // ชี้มาที่ Sort tab
      
    @State private var dorms: [Dorm] = []
    @State private var isLoading = true
    @State private var errorMessage: String?
    
    @EnvironmentObject var viewModel: UserProfileViewModel

    var body: some View {
        VStack(spacing: 0) {
            // Header
            HeaderView(title: "Find Match Dorm")
            
            ScrollView {
                VStack(spacing: 16) {
                    // Search bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search here", text: $searchText)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.top, 8)
                    
                    // Enter price range
                    HStack {
                        TextField("Min", text: $minPrice)
                            .keyboardType(.numberPad)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                        
                        TextField("Max", text: $maxPrice)
                            .keyboardType(.numberPad)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    
                    // Cards
VStack (alignment: .leading, spacing: 16) {
                    if isLoading {
                        ProgressView("Loading Dorms...")
                            .padding()
                    } else if let errorMessage = errorMessage {
                        Text("Error: \(errorMessage)")
                            .foregroundColor(.red)
                            .padding()
                    } else {
                        ForEach(dorms, id: \.id) { dorm in
                            let isFavorite = viewModel.favoriteDorms.contains(where: { $0.id == dorm.id })

                            CardView(imageName: "",
                                     title: dorm.name,
                                     rating: dorm.avg_review,
                                     priceRange: dorm.price,
                                     isFavorite: isFavorite)
                            
                        }
                    }
                }
                  .padding(.horizontal)
                  .padding(.top, 10)
                .task {
                    await fetchDorms()
                }

                }
            }
            .background(Color.white) // <<< background ScrollView ให้ขาว
            
            // Bottom Navigation
            BottomNavBarView(selectedTab: $selectedTab)
        }
        .background(Color.white) // <<< background ทั้งหน้าขาว
        .edgesIgnoringSafeArea(.bottom)
    }
    
    private func fetchDorms() async {
        do {
            isLoading = true
            errorMessage = nil
            dorms = try await DormManager.shared.fetchAllDorms()
            
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}

