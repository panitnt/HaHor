//
//  AuthenticationView.swift
//  HaHor
//
//  Created by bell on 21/4/2568 BE.
//

import SwiftUI

struct AuthenticationView: View {
    
    @Binding var showSignInView: Bool
    
    var body: some View {
        VStack{
            NavigationLink{
                SignInEmailView(showSignInView: $showSignInView)
            }label: {
                Text("Sign In with Email")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height:55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            NavigationLink{
                SignUpEmailView(showSignInView: $showSignInView)
            }label: {
                Text("Sign Up with Email")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height:55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Sign In")
    }
}

#Preview {
    NavigationStack{
        AuthenticationView(showSignInView: .constant(true))
    }
}
