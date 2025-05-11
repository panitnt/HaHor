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

    enum SortMode {
        case nameAZ
        case priceLowHigh
    }

    @State private var sortMode: SortMode = .nameAZ
    @EnvironmentObject var viewModel: UserProfileViewModel

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 16) {
                    
                    // Search bar with clear button
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("Search here", text: $searchText)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)

                        if !searchText.isEmpty || !minPrice.isEmpty || !maxPrice.isEmpty {
                            Button(action: {
                                searchText = ""
                                minPrice = ""
                                maxPrice = ""
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.top, 8)
                    
                    // Price input
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
                    
                    // Sort toggle button
                    HStack {
                        Spacer()
                        Button(action: {
                            sortMode = (sortMode == .nameAZ) ? .priceLowHigh : .nameAZ
                        }) {
                            HStack(spacing: 4) {
                                Image(systemName: "arrow.up.arrow.down")
                                Text(sortMode == .nameAZ ? "Sort: A-Z" : "Sort: Price")
                                    .font(.caption)
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding(.trailing)
                    }

                    // Dorm listing
                    VStack(alignment: .leading, spacing: 16) {
                        if viewModel.isDormLoading {
                            ProgressView("Loading Dorms...")
                                .padding()
                        } else if let errorMessage = viewModel.dormLoadError {
                            Text("Error: \(errorMessage)")
                                .foregroundColor(.red)
                                .padding()
                        } else {
                            // Filtering
                            let filteredDorms = viewModel.dorms.filter { dorm in
                                let matchesSearch = searchText.isEmpty || dorm.name.lowercased().contains(searchText.lowercased())

                                let priceComponents = dorm.price
                                    .components(separatedBy: CharacterSet(charactersIn: "-–"))
                                    .map { $0.trimmingCharacters(in: .whitespaces) }
                                    .map { $0.replacingOccurrences(of: ",", with: "") }

                                let dormMin = Int(priceComponents.first ?? "") ?? 0
                                let dormMax = Int(priceComponents.last ?? "") ?? Int.max

                                let userMin = Int(minPrice) ?? 0
                                let userMax = Int(maxPrice) ?? Int.max

                                let matchesPrice = dormMax >= userMin && dormMin <= userMax

                                return matchesSearch && matchesPrice
                            }

                            // Sorting
                            let sortedDorms: [Dorm] = {
                                switch sortMode {
                                case .nameAZ:
                                    return filteredDorms.sorted {
                                        $0.name.lowercased() < $1.name.lowercased()
                                    }
                                case .priceLowHigh:
                                    return filteredDorms.sorted {
                                        let a = Int($0.price.components(separatedBy: CharacterSet(charactersIn: "-–"))
                                            .first?.replacingOccurrences(of: ",", with: "").trimmingCharacters(in: .whitespaces) ?? "") ?? 0
                                        let b = Int($1.price.components(separatedBy: CharacterSet(charactersIn: "-–"))
                                            .first?.replacingOccurrences(of: ",", with: "").trimmingCharacters(in: .whitespaces) ?? "") ?? 0
                                        return a < b
                                    }
                                }
                            }()

                            // Display cards
                            ForEach(sortedDorms, id: \.id) { dorm in
                                let isFavorite = viewModel.favoriteDorms.contains { $0.id == dorm.id }
                                let ratingText = String(format: "%.1f", dorm.avg_review)

                                NavigationLink(destination: DormDetailView(dorm: dorm)) {
                                    CardView(
                                        imageName: dorm.name,
                                        title: dorm.name,
                                        rating: ratingText,
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
                }
            }
            .background(Color.white)
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.bottom)
    }
}
