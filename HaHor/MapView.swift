//
//  MapView.swift
//  HaHor
//
//  Created by bell on 21/4/2568 BE.
//
// MapView.swift (real data from Firestore)
import SwiftUI
import MapKit

//extension Dorm: Identifiable {
//    var id: String { name } // You can use dorm.id if exists
//}

struct DormLocation: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    let originalDorm: Dorm
}

struct MapView: View {
    @EnvironmentObject var viewModel: UserProfileViewModel

    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 13.8425, longitude: 100.5685),
        span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
    )

    @State private var selectedDorm: Dorm? = nil

    var dormLocations: [DormLocation] {
        viewModel.dorms.map {
            DormLocation(
                name: $0.name,
                coordinate: CLLocationCoordinate2D(latitude: $0.lat, longitude: $0.lon),
                originalDorm: $0
            )
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Map(coordinateRegion: $region, annotationItems: dormLocations) { location in
                    MapAnnotation(coordinate: location.coordinate) {
                        NavigationLink(
                            destination: DormDetailView(dorm: location.originalDorm)
                        ) {
                            Image(systemName: "mappin.circle.fill")
                                .font(.title)
                                .foregroundColor(.red)
                        }
                    }
                }
                .ignoresSafeArea()
            }
        }
    }
}

