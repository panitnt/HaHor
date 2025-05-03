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
    @State private var selectedTab: Int = 1
    
    @EnvironmentObject var viewModel: UserProfileViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            // Scrollable Content
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
                    
                    // Dorm Cards
                    VStack(alignment: .leading, spacing: 16) {
                        if viewModel.isDormLoading {
                            ProgressView("Loading Dorms...")
                                .padding()
                        } else if let errorMessage = viewModel.dormLoadError {
                            Text("Error: \(errorMessage)")
                                .foregroundColor(.red)
                                .padding()
                        } else {
                            let filteredDorms = viewModel.dorms.filter { dorm in
                                // Filter by name
                                let matchesSearch = searchText.isEmpty || dorm.name.lowercased().contains(searchText.lowercased())
                                
                                // Clean and parse price
                                let priceComponents = dorm.price
                                    .components(separatedBy: CharacterSet(charactersIn: "-–"))
                                    .map { $0.trimmingCharacters(in: .whitespaces) } // ตัดช่องว่าง
                                    .map { $0.replacingOccurrences(of: ",", with: "") } // ตัดจุลภาค
                                
                                let dormMin = Int(priceComponents.first ?? "") ?? 0
                                let dormMax = Int(priceComponents.last ?? "") ?? Int.max
                                
                                let userMin = Int(minPrice) ?? 0
                                let userMax = Int(maxPrice) ?? Int.max
                                
                                let matchesPrice = dormMax >= userMin && dormMin <= userMax
                                
                                return matchesSearch && matchesPrice
                                
                            }
                            
                            
                            ForEach(filteredDorms, id: \.id) { dorm in
                                let isFavorite = viewModel.favoriteDorms.contains(where: { $0.id == dorm.id })
                                NavigationLink {
                                        DormDetailView(dorm: dorm)
                                    } label: {
                                        CardView(
                                            folderName: dorm.name,
                                            title: dorm.name,
                                            rating: dorm.avg_review,
                                            priceRange: dorm.price,
                                            isFavorite: isFavorite,
                                            onFavoriteToggle: {
                                                if isFavorite {
                                                    viewModel.removeFavorite(dormId: dorm.id)
                                                } else {
                                                    viewModel.addFavorite(dormId: dorm.id)
                                                }
                                            }
                                        )

                                    }
                                    .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                    //                    .task {
                    //                        await viewModel.fetchDormsIfNeeded()
                    //                    }
                }
            }
            .background(Color.white)
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.bottom)
    }
}
