//
//  HeaderView.swift
//  HaHor
//
//  Created by bell on 21/4/2568 BE.
//

import SwiftUI

struct HeaderView: View {
    var title: String

    var body: some View {
        VStack(spacing: 6) {
//            Text("HAHOR")
//                .font(.custom("MarkerFelt-Wide", size: 28))
//                .tracking(2)
//                .bold()
            Image("HahorLogo")
                .resizable()
                .scaledToFit()
                .frame(height: 40)
//                .padding(.top, 60)

            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 10)
        .padding(.bottom, 10)
        .background(Color(red: 177/255, green: 238/255, blue: 61/255))
    }
}



#Preview {
    HeaderView(title: "Find Match Dorm")
}
