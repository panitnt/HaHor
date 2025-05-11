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

//    var dormLocations: [DormLocation] {
//        viewModel.dorms.map {
//            DormLocation(
//                name: $0.name,
//                coordinate: CLLocationCoordinate2D(latitude: $0.lat, longitude: $0.lon),
//                originalDorm: $0
//            )
//        }
//    }
    var dormLocations: [DormLocation] {
        viewModel.dorms.compactMap { dorm in
            let lat = dorm.lat
            let lon = dorm.lon

            // Validate coordinates
            guard lat.isFinite, lon.isFinite else {
                print("Invalid coordinate for dorm: \(dorm.name) → lat: \(lat), lon: \(lon)")
                return nil
            }

            return DormLocation(
                name: dorm.name,
                coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon),
                originalDorm: dorm
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

