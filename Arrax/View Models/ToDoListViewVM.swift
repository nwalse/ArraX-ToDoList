//
//  ToDoListViewVM.swift
//  Arrax
//
//  Created by Neel Walse on 5/23/23.
//
//import Firebase
import FirebaseFirestore
import Foundation

class ToDoListViewVM: ObservableObject {
    
    @Published var showingNewItemView = false
    private let userId: String
    
    init(userId: String) {
        self.userId = userId
    }
    
    
    func delete(id: String){
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(userId)
            .collection("todos")
            .document(id)
            .delete()
        
    }
}
