//
//  MapView.swift
//  HaHor
//
//  Created by bell on 21/4/2568 BE.
//

import SwiftUI
import MapKit

struct DormLocation: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct MapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 13.847, longitude: 100.571),
        span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
    )
    
    let dorms = [
        DormLocation(name: "The Pixels at Kaset", coordinate: CLLocationCoordinate2D(latitude: 13.846, longitude: 100.571)),
        DormLocation(name: "Chapter One The Campus Kaset", coordinate: CLLocationCoordinate2D(latitude: 13.845, longitude: 100.572)),
        DormLocation(name: "Miti Cheva", coordinate: CLLocationCoordinate2D(latitude: 13.8475, longitude: 100.5705))
    ]
    
    @State private var selectedDorm: DormLocation? = nil
    @State private var isDetailPresented = false
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $region, annotationItems: dorms) { dorm in
                MapAnnotation(coordinate: dorm.coordinate) {
                    Button {
                        selectedDorm = dorm
                        isDetailPresented = true
                    } label: {
                        Image(systemName: "mappin.circle.fill")
                            .font(.title)
                            .foregroundColor(.red)
                    }
                }
            }
            .ignoresSafeArea()
        }
        .sheet(isPresented: $isDetailPresented) {
            if let dorm = selectedDorm {
                DormDetailView(dormName: dorm.name)
            }
        }
    }
}

#Preview {
    MapView()
}
