//
//  BottomNavBarView.swift
//  HaHor
//
//  Created by bell on 21/4/2568 BE.
//

import SwiftUI

struct BottomNavBarView: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack {
            Spacer()
            navButton(index: 0, systemImage: "map.fill", label: "Map")
            Spacer()
            navButton(index: 1, systemImage: "arrow.up.arrow.down", label: "Sort")
            Spacer()
            navButton(index: 2, systemImage: "person.fill", label: "User")
            Spacer()
        }
        .padding(.top, 10)
        .padding(.bottom, 10)
        .background(Color(red: 177/255, green: 239/255, blue: 61/255)) // Light green
        //        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
        //        .shadow(radius: 4)
    }
    
    func navButton(index: Int, systemImage: String, label: String) -> some View {
            Button(action: {
                selectedTab = index
            }) {
                VStack(spacing: 4) {
                    Image(systemName: systemImage)
                        .font(.system(size: 24, weight: .medium))
                    Text(label)
                        .font(.caption)
                }
                .foregroundColor(selectedTab == index ? .black : .white)
            }
        }
}



//#Preview {
//    BottomNavBarView(selectedTab: 1)
//}

#Preview {
    PreviewWrapper()
}

struct PreviewWrapper: View {
    @State private var selectedTab = 2
    
    var body: some View {
        BottomNavBarView(selectedTab: $selectedTab)
            .previewLayout(.sizeThatFits)
        //            .padding()
    }
}
