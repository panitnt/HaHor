//
//  ReviewCardView.swift
//  HaHor
//
//  Created by bell on 11/5/2568 BE.
//
import SwiftUI

struct ReviewCard: View {
    let review: Review
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Star Rating
            Text(String(repeating: "⭐️", count: review.star))
                .font(.headline)
            
            // Comment
            Text(review.comment)
                .font(.subheadline)
                .fixedSize(horizontal: false, vertical: true)
            
            // Date and User
            HStack {
                if let ts = review.timestamp {
                    Text(ts, style: .date)
                } else {
                    Text("none")
                }
                Spacer()
                Text("by \(review.by)")
            }
            .font(.caption)
            .foregroundColor(.gray)
        }
        .padding(12) 
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
