//
//  DormDetailView.swift
//  HaHor
//
//  Created by Preme on 27/4/2568 BE.
//

import SwiftUI

struct DormDetailView: View {
    @State private var currentDorm: Dorm
    @State private var isReviewPresented = false
    @State private var isAddReviewPresented = false

    @EnvironmentObject var viewModel: UserProfileViewModel

    init(dorm: Dorm) {
        _currentDorm = State(initialValue: dorm)
    }

    private func toggleFavorite() {
        if viewModel.favoriteDorms.contains(where: { $0.id == currentDorm.id }) {
            viewModel.removeFavorite(dormId: currentDorm.id)
        } else {
            viewModel.addFavorite(dormId: currentDorm.id)
        }
    }

    private func sanitizeAssetName(from name: String) -> String {
        name.replacingOccurrences(of: " ", with: "")
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Header
                HeaderView(title: currentDorm.name)

                // Image from Assets.xcassets
                let imageName = sanitizeAssetName(from: currentDorm.name)
                HStack {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .clipped()
                }
                .frame(maxWidth: .infinity)

                // Facilities
                VStack(alignment: .leading, spacing: 8) {
                    Text("Amenities")
                        .font(.headline)
                    HStack {
                        if currentDorm.amenities.wifi { Label("Wifi", systemImage: "wifi") }
                        if currentDorm.amenities.fitness { Label("Fitness", systemImage: "figure.walk") }
                        if currentDorm.amenities.washingmachine { Label("Washing Machine", systemImage: "washer") }
                    }
                    HStack {
                        if currentDorm.amenities.clothesdryer { Label("Clothes Dryer", systemImage: "wind") }
                        if currentDorm.amenities.carpark { Label("Parking lot", systemImage: "car.fill") }
                        if currentDorm.amenities.autolockdoor { Label("Auto-lock", systemImage: "lock.fill") }
                    }
                }
                .padding(.horizontal)

                // Contact Info
                VStack(alignment: .leading, spacing: 8) {
                    Text("Contact Information")
                        .font(.headline)
                    Label(currentDorm.contact.phone, systemImage: "phone.fill")
                    Label(currentDorm.contact.email, systemImage: "envelope.fill")
                    Label(currentDorm.contact.address, systemImage: "location.fill")
                }
                .font(.subheadline)
                .padding(.horizontal)

                // Price
                Text("Price: ฿\(currentDorm.price)")
                    .font(.headline)
                    .padding(.horizontal)

                // Rating Summary
                HStack {
                    Text("Average Rating: \(String(format: "%.1f", currentDorm.avg_review)) ⭐️ (\(currentDorm.review_count) reviews)")
                        .font(.subheadline)
                    Spacer()
                    Button(action: {
                        isReviewPresented = true
                    }) {
                        HStack {
                            Text("Read Review")
                            Image(systemName: "arrow.right")
                        }
                        .foregroundColor(.green)
                    }
                }
                .padding(.horizontal)
            }
        }
        .sheet(isPresented: $isReviewPresented) {
            VStack(spacing: 0) {
                HeaderView(title: "\(currentDorm.name)'s Reviews")
                    .padding(.bottom)

                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(currentDorm.review, id: \.comment) { r in
                            ReviewCard(review: r)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .padding(.horizontal, 16) // Just outer padding
                    .padding(.bottom)
                }
            }
        }


        .sheet(isPresented: $isAddReviewPresented, onDismiss: {
            Task {
                if let updatedDorm = try? await DormManager.shared.fetchDorm(by: currentDorm.id) {
                    currentDorm = updatedDorm
                }
            }
        }) {
            AddReviewView(dorm: currentDorm)
        }
        .navigationTitle(currentDorm.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: {
                    toggleFavorite()
                }) {
                    Image(systemName: viewModel.favoriteDorms.contains(where: { $0.id == currentDorm.id }) ? "heart.fill" : "heart")
                }

                Button(action: {
                    isAddReviewPresented = true
                }) {
                    Image(systemName: "plus")
                }
            }
        }
        .toolbarBackground(Color(red: 177/255, green: 239/255, blue: 61/255), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

