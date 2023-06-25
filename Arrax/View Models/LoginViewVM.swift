//
//  LoginViewVM.swift
//  Arrax
//
//  Created by Neel Walse on 5/23/23.
//
import FirebaseAuth
import Foundation

class LoginViewVM: ObservableObject{
    @Published var email = ""
    @Published var password = ""
    @Published var error = ""
    
    init(){}
    /*
    func login(){
        guard validate() else {
            return
        }
        
        //Try to login
        Auth.auth().signIn(withEmail: email, password: password)
        
        if error == "" {
            error = "Incorrect password or email."
        }
        
    }
    */
    func login() {
        guard validate() else {
            return
        }
        
        // Try to login
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (authResult, error) in
            if let error = error {
                // Authentication failed, set error message
                self?.error = "Incorrect password or email."
                print("Authentication failed: \(error.localizedDescription)")
            } else {
                // Authentication succeeded
                self?.error = "" // Clear error message
            }
        }
    }


    
    private func validate() -> Bool{
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
                !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            
            error = "Please fill in all fields."
            return false
        }
        
        guard email.contains("@") && email.contains(".") else{
            error = "Please enter a valid email."
            return false
        }
        error = ""
        return true
    }
    
}

