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
            Image("HahorLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 180, height: 100)
                .padding(40)
            
            Text("Please Signin/Login before using HaHor")
                .foregroundColor(.black)
                .frame(height:55)
            
            NavigationLink{
                SignUpEmailView(showSignInView: $showSignInView)
            }label: {
                Text("Sign Up")
                    .font(.headline)
                    .foregroundColor(Color(UIColor.white))
                    .frame(height:55)
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 177/255, green: 239/255, blue: 61/255))
                    .cornerRadius(10)
            }
                        
            NavigationLink{
                SignInEmailView(showSignInView: $showSignInView)
            }label: {
                Text("Sign In (Already have account)")
                    .font(.headline)
                    .frame(height:55)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(Color(UIColor.black))
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Sign In / Sign Up")
    }
}

#Preview {
    NavigationStack{
        AuthenticationView(showSignInView: .constant(true))
    }
}
