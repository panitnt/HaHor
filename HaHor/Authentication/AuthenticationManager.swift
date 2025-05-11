//
//  AuthenticationManager.swift
//  HaHor
//
//  Created by bell on 21/4/2568 BE.
//

import Foundation
import FirebaseAuth

struct AuthDataResultModel{
    let uid: String
    let email: String?
    let username: String?
    
    init(user: User){
        self.uid = user.uid
        self.email = user.email
        self.username = user.displayName
    }
}


final class AuthnticationManager {
    
    // instance
    static let shared = AuthnticationManager()
    private init(){}
    
    func getAuthenticatedUser() throws -> AuthDataResultModel? {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        return AuthDataResultModel(user: user)
    }
    
    func createUser(email: String, username: String, password: String) async throws -> AuthDataResultModel{
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        
        // update username
        let changeRequest = authDataResult.user.createProfileChangeRequest()
        changeRequest.displayName = username
        try await changeRequest.commitChanges()
        
        let authDataResultModel = AuthDataResultModel(user: authDataResult.user)
        
        // add user into firestore database
        try await UserManager.shared.createNewUser(auth: authDataResultModel)
        
        return authDataResultModel
    }
    
    func signInUser(email: String, password: String) async throws -> AuthDataResultModel{
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    func signOut() throws{
        try Auth.auth().signOut()
    }
}
