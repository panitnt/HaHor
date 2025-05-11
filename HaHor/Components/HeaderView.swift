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
            Text("HAHOR")
                .font(.system(size: 28, weight: .bold))
                .tracking(2)

//            Image("HahorHeaderLogo")
//                .resizable()
//                .scaledToFit()
//                .frame(height: 40)
//                .padding(.top, 60)

            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 10)
        .padding(.bottom, 10)
        .background(Color(red: 177/255, green: 239/255, blue: 61/255))
    }
}



#Preview {
    HeaderView(title: "Find Match Dorm")
}
