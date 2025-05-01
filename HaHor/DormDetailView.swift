//  DormDetailView.swift
//  HaHor
//
//  Created by Preme on 27/4/2568 BE.
//
import SwiftUI

struct DormDetailView: View {
    var dorm: Dorm
    @State private var isReviewPresented = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Header
                HeaderView(title: dorm.name)

                // Image (placeholder)
                Image("dorm_placeholder")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .clipped()

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
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    HeaderView(title: "รีวิวทั้งหมดของ \(dorm.name)")
                        .padding(.bottom)

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
    }
}
