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
    
    func login(){
        guard validate() else {
            return
        }
        if error == "" {
            error = "Incorrect password or email."
        }
        //Try to login
        Auth.auth().signIn(withEmail: email, password: password)
        
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
