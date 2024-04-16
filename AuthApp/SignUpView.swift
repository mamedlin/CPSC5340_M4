//
//  SignUpView.swift
//  AuthApp
//
//  Created by Michael Medlin on 4/15/24.
//

import SwiftUI
import Firebase

struct SignUpView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var errorMessage: String?
    @Binding var isShowingLogin: Bool

    var body: some View {
        VStack(spacing: 20) {
            Text("Register!")
                .font(.system(size: 40, weight: .bold, design: .rounded))
                .offset(x: -90)
            
            TextField("Email", text: $email)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)

            SecureField("Password", text: $password)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)

            SecureField("Confirm Password", text: $confirmPassword)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)

            Button("Sign Up") {
                signUpUser()
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(8)

            if let message = errorMessage {
                Text(message)
                    .foregroundColor(.red)
            }
            Button(isShowingLogin ? "Sign Up" : "Login") {
                isShowingLogin.toggle()
            }
        }
        .padding()
    }

    func signUpUser() {
        if password != confirmPassword {
            errorMessage = "Passwords do not match"
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                errorMessage = error.localizedDescription
            } else {
                isShowingLogin = true
                errorMessage = nil
                email = ""
                password = ""
                confirmPassword = ""
            }
        }
    }
}

