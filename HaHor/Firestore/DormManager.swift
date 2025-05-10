//
//  DormManager.swift
//  HaHor
//
//  Created by bell on 22/4/2568 BE.
//

import Foundation
import FirebaseFirestore
import FirebaseCore

struct Dorm : Identifiable{
    var id: String = UUID().uuidString
    
    var name: String
    var lat: Double
    var lon: Double
    var price: String
    var avg_review: String
    var amenities: Amenities
    var contact: Contact
    var review: [Review]
}

struct Amenities {
    var autolockdoor: Bool
    var carpark: Bool
    var clothesdryer: Bool
    var fitness: Bool
    var washingmachine: Bool
    var wifi: Bool
}

struct Contact{
    var address: String
    var email: String
    var phone: String
}

struct Review {
    var comment: String
    var star: Int
    var by: String
    var displayAsAnonymous: Bool
    var timestamp: Date?
}



final class DormManager {
    static let shared = DormManager()
    private init() {}

    func fetchDorm(by id: String) async throws -> Dorm? {
        let doc = try await Firestore.firestore().collection("dorm").document(id).getDocument()
        guard let data = doc.data() else { return nil }

        // Parse nested fields
        let amenitiesData = data["amenities"] as? [String: Any] ?? [:]
        let amenities = Amenities(
            autolockdoor: amenitiesData["autolockdoor"] as? Bool ?? false,
            carpark: amenitiesData["carpark"] as? Bool ?? false,
            clothesdryer: amenitiesData["clothesdryer"] as? Bool ?? false,
            fitness: amenitiesData["fitness"] as? Bool ?? false,
            washingmachine: amenitiesData["washingmachine"] as? Bool ?? false,
            wifi: amenitiesData["wifi"] as? Bool ?? false
        )

        let contactData = data["contact"] as? [String: Any] ?? [:]
        let contact = Contact(
            address: contactData["address"] as? String ?? "",
            email: contactData["email"] as? String ?? "",
            phone: contactData["phone"] as? String ?? ""
        )

        let reviewList = data["review"] as? [[String: Any]] ?? []
        let reviews: [Review] = reviewList.map { r in
            Review(
                comment: r["comment"] as? String ?? "",
                star: r["star"] as? Int ?? 0,
                by: r["by"] as? String ?? "Unknown",
                displayAsAnonymous: r["displayAsAnonymous"] as? Bool ?? false,
                timestamp: (r["timestamp"] as? Timestamp)?.dateValue() ?? Date()
            )
        }

        return Dorm(
            id: id,
            name: data["name"] as? String ?? "Unknown",
            lat: data["lat"] as? Double ?? 0.0,
            lon: data["lon"] as? Double ?? 0.0,
            price: data["price"] as? String ?? "",
            avg_review: data["avg_review"] as? String ?? "",
            amenities: amenities,
            contact: contact,
            review: reviews
        )
    }
    
    func fetchAllDorms() async throws -> [Dorm] {
        let snapshot = try await Firestore.firestore().collection("dorm").getDocuments()
        
        var allDorms: [Dorm] = []
        
        for document in snapshot.documents {
            let id = document.documentID
            let data = document.data()
            
            // Parse like before
            let amenitiesData = data["amenities"] as? [String: Any] ?? [:]
            let amenities = Amenities(
                autolockdoor: amenitiesData["autolockdoor"] as? Bool ?? false,
                carpark: amenitiesData["carpark"] as? Bool ?? false,
                clothesdryer: amenitiesData["clothesdryer"] as? Bool ?? false,
                fitness: amenitiesData["fitness"] as? Bool ?? false,
                washingmachine: amenitiesData["washingmachine"] as? Bool ?? false,
                wifi: amenitiesData["wifi"] as? Bool ?? false
            )
            
            let contactData = data["contact"] as? [String: Any] ?? [:]
            let contact = Contact(
                address: contactData["address"] as? String ?? "",
                email: contactData["email"] as? String ?? "",
                phone: contactData["phone"] as? String ?? ""
            )
            
            let reviewList = data["review"] as? [[String: Any]] ?? []
            let reviews: [Review] = reviewList.map {
            let timestamp = ($0["timestamp"] as? Timestamp)?.dateValue() ?? Date.distantPast

            return Review(
                    comment: $0["comment"] as? String ?? "",
                    star: $0["star"] as? Int ?? 0,
                    by: $0["by"] as? String ?? "Unknown",
                    displayAsAnonymous: $0["displayAsAnonymous"] as? Bool ?? false,
                    timestamp: timestamp
                )
            }

            let dorm = Dorm(
                id: id,
                name: data["name"] as? String ?? "Unknown",
                lat: data["lat"] as? Double ?? 0.0,
                lon: data["lon"] as? Double ?? 0.0,
                price: data["price"] as? String ?? "",
                avg_review: data["avg_review"] as? String ?? "",
                amenities: amenities,
                contact: contact,
                review: reviews
            )
            
            allDorms.append(dorm)
        }
        
        return allDorms
    }

}

