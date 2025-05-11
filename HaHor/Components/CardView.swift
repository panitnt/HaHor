//
//  CardView.swift
//  HaHor
//
//  Created by bell on 21/4/2568 BE.
//

import SwiftUI

struct CardView: View {
    var imageName: String
    var title: String
    var rating: String
    var priceRange: String
    var isFavorite: Bool
    var onFavoriteToggle: () -> Void


    func sanitizeAssetName(from name: String) -> String {
        return name
            .replacingOccurrences(of: " ", with: "")
    }

    var body: some View {
        HStack(alignment: .top) {
            Image(sanitizeAssetName(from: imageName))
                .resizable()
                .frame(width: 100, height: 80)
                .cornerRadius(8)
                .scaledToFill()

            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Image(systemName: "mappin.and.ellipse")
                        .foregroundColor(.red)
                    Text(title)
                        .font(.headline)
                    Spacer()
                    Button(action: {
                        onFavoriteToggle()
                    }) {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .foregroundColor(.red)
                    }
                    .buttonStyle(PlainButtonStyle())
                }

                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text(rating)
                        .font(.subheadline)
                }

                HStack {
                    Image(systemName: "tag.fill")
                        .foregroundColor(.green)
                    Text(priceRange)
                        .font(.subheadline)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}


//#Preview {
//    CardView(imageName: "HahorLogo", title: "Hahor", rating: "5.0", priceRange: "400-20000", isFavorite: false)
//}
