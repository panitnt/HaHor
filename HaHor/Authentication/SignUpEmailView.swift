//
//  SignUpEmailView.swift
//  HaHor
//
//  Created by bell on 21/4/2568 BE.
//

import SwiftUI

@MainActor
final class SignUpEmailViewModel: ObservableObject {
    @Published var email = ""
    @Published var username = ""
    @Published var password = ""
    @Published var cfpassword = ""

    @Published var signInError: String? = nil
    
    func signUp() async throws {
        guard !email.isEmpty,!username.isEmpty, !password.isEmpty, !cfpassword.isEmpty else {
                throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Please fill all the fields."])
            }
            guard password == cfpassword else {
                throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Passwords do not match."])
            }
        let _ = try await AuthnticationManager.shared.createUser(email: email, username: username, password: password)
        
//        Task {
//            do {
//                let returnUserData = try await AuthnticationManager.shared.createUser(email: email, password: password)
//                print("User success")
//                print(returnUserData)
//                self.signInError = nil // success, no error
//            } catch {
//                self.signInError = error.localizedDescription
//            }
//        }
    }
}


struct SignUpEmailView: View {
    
    @StateObject private var viewModel = SignUpEmailViewModel()
        
    @State private var showAlert = false
    @State private var errorMessage = ""
    
    @Binding var showSignInView: Bool
    
    
    var body: some View {
        VStack(spacing: 20) {
            // Logo
            Image("HahorLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 180, height: 100)
                .padding(.top, 60)
            
            // Title
            Text("Sign Up")
                .font(.title)
                .bold()
            
            Text("Enter your email and password")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            // TextFields
            VStack(spacing: 16) {
                TextField("Email", text: $viewModel.email)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                
                TextField("Username", text: $viewModel.username)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                    .autocapitalization(.none)
                
                SecureField("Password", text: $viewModel.password)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                
                SecureField("Confirm Password", text: $viewModel.cfpassword)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
            }
            .padding(.horizontal, 32)
            
            // Login Button
            Button(action: {
                Task{
                    do{
                        try await viewModel.signUp()
                        showSignInView = false
                        return
                    } catch{
                        self.showAlert = true
                        self.errorMessage = error.localizedDescription
                        return
                    }
                }
                
            }) {
                Text("Sign Up")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 32)
            .padding(.top, 10)
            
            // Sign Up Text
//            HStack {
//                Text("Already have an account?")
//                Button(action: {
//                    // Navigate to sign up
//                }) {
//                    Text("sign in")
//                        .underline()
//                }
//            }
//            .font(.footnote)
//            //            .padding(.bottom, 20)
            Spacer()
        }
        .navigationTitle("Sign Up new account")
        .onReceive(viewModel.$signInError) { error in
            if let error = error {
                self.errorMessage = error
                self.showAlert = true
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Sign Up Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
        }
        //        .ignoresSafeArea(edges: .top)
    } // end view
}


#Preview {
    SignUpEmailView(showSignInView: .constant(true))
}
