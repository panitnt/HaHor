//
//  DormDetailView.swift
//  HaHor
//
//  Created by Preme on 27/4/2568 BE.
//

import SwiftUI

struct DormDetailView: View {
    var dorm: Dorm
    @State private var isReviewPresented = false
    @EnvironmentObject var viewModel: UserProfileViewModel

    private func toggleFavorite() {
        if viewModel.favoriteDorms.contains(where: { $0.id == dorm.id }) {
            viewModel.removeFavorite(dormId: dorm.id)
        } else {
            viewModel.addFavorite(dormId: dorm.id)
        }
    }

    private func sanitizeAssetName(from name: String) -> String {
        return name
            .replacingOccurrences(of: " ", with: "")
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Header
                HeaderView(title: dorm.name)

                // Image from Assets.xcassets
                let imageName = sanitizeAssetName(from: dorm.name)
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
                    Text("สิ่งอำนวยความสะดวก")
                        .font(.headline)
                    HStack {
                        if dorm.amenities.wifi { Label("Wifi", systemImage: "wifi") }
                        if dorm.amenities.fitness { Label("Fitness", systemImage: "figure.walk") }
                        if dorm.amenities.washingmachine { Label("เครื่องซักผ้า", systemImage: "washer") }
                    }
                    HStack {
                        if dorm.amenities.clothesdryer { Label("เครื่องอบผ้า", systemImage: "wind") }
                        if dorm.amenities.carpark { Label("ที่จอดรถ", systemImage: "car.fill") }
                        if dorm.amenities.autolockdoor { Label("Auto-lock", systemImage: "lock.fill") }
                    }
                }
                .padding(.horizontal)

                // Contact Info
                VStack(alignment: .leading, spacing: 8) {
                    Text("ติดต่อ")
                        .font(.headline)
                    Label(dorm.contact.phone, systemImage: "phone.fill")
                    Label(dorm.contact.email, systemImage: "envelope.fill")
                    Label(dorm.contact.address, systemImage: "location.fill")
                }
                .font(.subheadline)
                .padding(.horizontal)

                // Price
                Text("ราคา: ฿\(dorm.price)")
                    .font(.subheadline)
                    .padding(.horizontal)

                // Rating Summary
                HStack {
                    Text("รีวิว: \(dorm.avg_review)")
                        .font(.subheadline)
                    Spacer()
                    Button(action: {
                        isReviewPresented = true
                    }) {
                        HStack {
                            Text("ดูรีวิว")
                            Image(systemName: "arrow.right")
                        }
                        .foregroundColor(.green)
                    }
                }
                .padding(.horizontal)
            }
        }
        .sheet(isPresented: $isReviewPresented) {
            HeaderView(title: "รีวิวทั้งหมดของ \(dorm.name)")
                .padding(.bottom)
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ForEach(dorm.review, id: \.comment) { r in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(String(repeating: "⭐️", count: r.star))
                                .font(.headline)
                            Text(r.comment)
                                .font(.subheadline)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                    }
                }
                .padding()
            }
        }
        .navigationTitle(dorm.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    toggleFavorite()
                }) {
                    Image(systemName: viewModel.favoriteDorms.contains(where: { $0.id == dorm.id }) ? "heart.fill" : "heart")
                }
            }
        }
        .toolbarBackground(Color(red: 177/255, green: 239/255, blue: 61/255), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}
