//
//  DormDetailView.swift
//  HaHor
//
//  Created by Preme on 27/4/2568 BE.
//

import SwiftUI

struct DormDetailView: View {
    var dormName: String
    @State private var isReviewPresented = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header
            HeaderView(title: dormName)
            
            // Image
            Image("dorm1") // เปลี่ยนเป็นรูปจริง
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .clipped()
            
            // Facilities
            VStack(alignment: .leading, spacing: 8) {
                Text("สิ่งอำนวยความสะดวก")
                    .font(.headline)
                Text("✔️ Wifi\n✔️ Fitness\n✔️ เครื่องซักผ้า\n✔️ ที่จอดรถ\n✔️ เครื่องอบผ้า\n✔️ Auto-lock door")
                    .font(.subheadline)
            }
            .padding(.horizontal)
            
            // Contact
            VStack(alignment: .leading, spacing: 8) {
                Text("Contact")
                    .font(.headline)
                Label("0987654321", systemImage: "phone.fill")
                Label("helloworld@mail.com", systemImage: "envelope.fill")
                Label("98/57 ซอยงามวงศ์วาน 52", systemImage: "location.fill")
            }
            .font(.subheadline)
            .padding(.horizontal)
            
            // Price
            Text("Price: ฿6,000 - ฿8,000")
                .font(.subheadline)
                .padding(.horizontal)
            
            Spacer()
            
            // Review Section
            HStack {
                Text("Review: 5 ⭐ (2)")
                    .font(.subheadline)
                Spacer()
                Button(action: {
                    isReviewPresented = true
                }) {
                    HStack {
                        Text("see review")
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.green)
                }
            }
            .padding()
        }
        .sheet(isPresented: $isReviewPresented) {
            ReviewView(dormName: dormName)
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    DormDetailView(dormName: "The Pixels at Kaset")
}
