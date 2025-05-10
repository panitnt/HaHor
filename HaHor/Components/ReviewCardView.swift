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
        VStack(alignment: .leading, spacing: 4) {
            Text(String(repeating: "⭐️", count: review.star))
                .font(.headline)
            
            Text(review.comment)
                .font(.subheadline)
            
            HStack(spacing: 8) {
                
                if let ts = review.timestamp {
                    Text(ts, style: .date)
                        .font(.caption)
                        .foregroundColor(.gray)
                } else {
                    Text("none")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Text("by \(review.by)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}
