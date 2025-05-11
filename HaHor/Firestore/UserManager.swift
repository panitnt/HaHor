//
//  UserManager.swift
//  HaHor
//
//  Created by bell on 22/4/2568 BE.
//

import Foundation
import FirebaseFirestore
import FirebaseCore

struct DBUser{
    let userId: String
    let email: String
    let username: String
    let favorite: [String]
}

final class UserManager{
    static let shared = UserManager()
    private init(){}
    
    func createNewUser(auth: AuthDataResultModel) async throws{
        let userData: [String: Any] = [
            "user_id" : auth.uid,
            "email" : auth.email ?? "",
            "display_name" : auth.username ?? "",
            "favorite": []
        ]
        
        try await Firestore.firestore().collection("users").document(auth.uid).setData(userData, merge: false)
    }
    
    func getUser(userId: String) async throws -> DBUser{
        let snapshot = try await Firestore.firestore().collection("users").document(userId).getDocument()
        
        guard let data = snapshot.data(), let userId = data["user_id"] as? String  else{
            throw URLError(.badServerResponse)
        }
        
        let email = data["email"] as? String ?? ""
        let username = data["display_name"] as? String ?? ""
        let favorite = data["favorite"] as? [String] ?? []
        
        return DBUser(userId: userId, email: email, username: username, favorite: favorite)
    }
}
