import SwiftUI

struct SortView: View {
    @State private var searchText: String = ""
    @State private var minPrice: String = ""
    @State private var maxPrice: String = ""
    @State private var selectedTab: Int = 1 // ชี้มาที่ Sort tab
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HeaderView(title: "Find Match Dorm")
            
            ScrollView {
                VStack(spacing: 16) {
                    // Search bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search here", text: $searchText)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.top, 8)
                    
                    // Enter price range
                    HStack {
                        TextField("Min", text: $minPrice)
                            .keyboardType(.numberPad)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                        
                        TextField("Max", text: $maxPrice)
                            .keyboardType(.numberPad)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    
                    // Cards
                    VStack(spacing: 12) {
                        CardView(imageName: "dorm1", title: "The Pixels at Kaset", rating: "5(2)", priceRange: "6,000-8,000", isFavorite: true)
                        CardView(imageName: "dorm2", title: "Chapter One The Campus Kaset", rating: "5(2)", priceRange: "6,000-8,000", isFavorite: true)
                        CardView(imageName: "dorm3", title: "Miti Cheva", rating: "4.8(49)", priceRange: "9,000-17,000", isFavorite: false)
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                }
            }
            .background(Color.white) // <<< background ScrollView ให้ขาว
            
            // Bottom Navigation
            BottomNavBarView(selectedTab: $selectedTab)
        }
        .background(Color.white) // <<< background ทั้งหน้าขาว
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    SortView()
}
