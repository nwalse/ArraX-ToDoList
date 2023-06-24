//
//  RegisterViewVM.swift
//  Arrax
//
//  Created by Neel Walse on 5/23/23.
//
import FirebaseFirestore
import FirebaseAuth
import Foundation

class RegisterViewVM: ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var error = ""
    
    init() {}
    
    func register() {
        guard validate() else{
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let userId = result?.user.uid else{
                return
            }
            self?.insertUR(id: userId)
        }
        
    }
    
    private func insertUR(id: String){
        let newUser = User(id: id,
                           name: name,
                           email: email,
                           joined: Date().timeIntervalSince1970)
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(id)
            .setData(newUser.asDictionary())
        
    }
    
    
    
    private func validate() -> Bool{
        //error = ""
        
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
                !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            
            error = "Please fill in all fields."
            return false
        }
        
        guard email.contains("@") && email.contains(".") else{
            error = "Please enter a valid email."
            return false
        }
        
        guard password.count >= 6 else{
            error = "Password length must be > 5."
            return false
        }
        
        return true
    }
}
