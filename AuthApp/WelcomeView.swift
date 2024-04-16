//
//  WelcomeView.swift
//  AuthApp
//
//  Created by Michael Medlin on 4/15/24.
//

import SwiftUI
import Firebase

struct WelcomeView: View {
    @Binding var isShowingLogin: Bool
    @Binding var isLoggedIn: Bool
    let userEmail: String? = UserDefaults.standard.string(forKey: "userEmail")

    var body: some View {
        VStack {
            Text("Welcome, \(userEmail ?? "")!")
                .font(.largeTitle)
                .padding()
            Text("You successfully logged in!")
            
            Button("Logout") {
                logout()
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
    }

    func logout() {
        do {
            try Auth.auth().signOut()
            UserDefaults.standard.removeObject(forKey: "userEmail")
            isLoggedIn.toggle()
            isShowingLogin.toggle()
            
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

