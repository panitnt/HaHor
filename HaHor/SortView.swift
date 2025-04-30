//
//  SortView.swift
//  HaHor
//
//  Created by bell on 21/4/2568 BE.
//

import SwiftUI

//
//  DormListView.swift
//  HaHor
//
//  Created by bell on 30/4/2568 BE.
//

import SwiftUI

struct SortView: View {
    @State private var dorms: [Dorm] = []
    @State private var isLoading = true
    @State private var errorMessage: String?
    
    @EnvironmentObject var viewModel: UserProfileViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                
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
                .padding()
                .task {
                    await fetchDorms()
                }
            }}
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

