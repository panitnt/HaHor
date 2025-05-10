//
//  ReviewView.swift
//  HaHor
//
//  Created by Preme on 27/4/2568 BE.
//

//import SwiftUI
//
//struct ReviewView: View {
//    var dormName: String
//    
//    var body: some View {
//        VStack {
//            HeaderView(title: dormName)
//            
//            List {
//                ReviewItem(star: 5, comment: "หอมีสภาพดีมาก สะอาด อยู่ในซอยไม่ลึกมาก เดินเข้าไปสะดวก")
//                ReviewItem(star: 3, comment: "หน้าหอไม่สวยแต่ข้างในดีโอเคเลย")
//                ReviewItem(star: 5, comment: "หอไม่มีปัญหาเลย เงียบสงบดี มีรปภ.")
//            }
//        }
//        .background(Color.white)
//    }
//}
//
//struct ReviewItem: View {
//    var star: Int
//    var comment: String
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 4) {
//            HStack {
//                ForEach(0..<star, id: \.self) { _ in
//                    Image(systemName: "star.fill")
//                        .foregroundColor(.yellow)
//                }
//            }
//            Text(comment)
//                .font(.body)
//        }
//        .padding(.vertical, 8)
//    }
//}
//
//#Preview {
//    ReviewView(dormName: "The Pixels at Kaset")
//}
