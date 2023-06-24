//
//  ToDoListItemViewVM.swift
//  Arrax
//
//  Created by Neel Walse on 5/23/23.
//
import FirebaseAuth
import FirebaseFirestore
import Foundation
import SwiftUI

class ToDoListItemViewVM: ObservableObject {
    
    @Published var showingNewItemView = false
    
    init() {}
    
    func toggleIsDone(item: ToDoListItem) {
        var itemCopy = item
        itemCopy.setDone(!item.isDone)
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(uid)
            .collection("todos")
            .document(itemCopy.id)
            .setData(itemCopy.asDictionary())
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            if itemCopy.isDone {
                db.collection("users")
                    .document(uid)
                    .collection("todos")
                    .document(itemCopy.id)
                    .delete()
            }
        }
        
        
    }
    
    
    
}
