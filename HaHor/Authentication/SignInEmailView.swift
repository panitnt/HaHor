//
//  SignInEmailView.swift
//  HaHor
//
//  Created by bell on 21/4/2568 BE.
//

import SwiftUI

@MainActor
final class SignInEmailViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var signInError: String? = nil
    @Published var isLoading = false
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Please fill all the fields."])
        }
        isLoading = true
        defer { isLoading = false }
        let _ = try await AuthnticationManager.shared.signInUser(email: email, password: password)
        UserProfileViewModel.shared.loadUser()
    }
}



struct SignInEmailView: View {
    
    @StateObject private var viewModel = SignInEmailViewModel()
    
    @State private var showAlert = false
    @State private var errorMessage = ""
    
    @Binding var showSignInView: Bool
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                // Logo
                Image("HahorLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 180, height: 100)
                    .padding(.top, 60)
                
                // Title
                Text("Sign In")
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
                    
                    SecureField("Password", text: $viewModel.password)
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(10)
                }
                .padding(.horizontal, 32)
                
                // Login Button
                Button(action: {
                    Task {
                        do {
                            try await viewModel.signIn()
                            showSignInView = false
                        } catch {
                            self.errorMessage = error.localizedDescription
                            self.showAlert = true
                        }
                    }
                }) {
                    Text("Log in")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 32)
                .padding(.top, 10)
                
                // Sign Up Text
                HStack {
                    Text("Don’t have an account? please sign up")
                }
                .font(.footnote)
                
                Spacer()
            }
            .disabled(viewModel.isLoading)
            .blur(radius: viewModel.isLoading ? 3 : 0)
            
            if viewModel.isLoading {
                ProgressView("Signing In…")
                    .padding(20)
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .shadow(radius: 10)
            }
        }
        .navigationTitle("Sign in with Email")
        .onReceive(viewModel.$signInError) { error in
            if let error = error {
                self.errorMessage = error
                self.showAlert = true
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Sign In Error"), message: Text("Wrong Username or Password"), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    NavigationStack{
        SignInEmailView(showSignInView: .constant(false))
    }
}
