//
//  NewItemViewVM.swift
//  Arrax
//
//  Created by Neel Walse on 5/23/23.
//
import FirebaseAuth
import FirebaseFirestore
import Foundation
import UIKit
import UserNotifications

class NewItemViewVM: ObservableObject {
    @Published var title = ""
    @Published var dueDate = Date()
    @Published var showAlert = false
    
    init() {}
    
    func save(){
        guard canSave else {
            return
        }
        
        //get user id
        guard let uId = Auth.auth().currentUser?.uid else{
            return
        }
        
        //create model
        let newId = UUID().uuidString
        let newItem = ToDoListItem(id: newId,
                                   title: title,
                                   dueDate: dueDate.timeIntervalSince1970,
                                   createdDate: Date().timeIntervalSince1970,
                                   isDone: false)
        
        
        //create notification
        let timestampInSeconds = dueDate.timeIntervalSince1970
        
        let date = Date(timeIntervalSince1970: timestampInSeconds)
        let calendar = Calendar.current
        var dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let hour = calendar.component(.hour, from: dueDate)
        let minute = calendar.component(.minute, from: dueDate)
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        
        let identifier = newId
        let titlen = title
        var listhour = hour
        let isDaily = false
        
        

        let notificationCenter = UNUserNotificationCenter.current()
        
        if hour > 12{
            listhour = hour - 12
        }
        if hour == 0{
            listhour = 12
        }
        var mins = ""
        if minute <= 9{
            mins = "0"
        }
        
        let content = UNMutableNotificationContent()
        content.title = titlen
        content.body = "Time - " + String(listhour) + ":" + mins + String(minute)
        content.sound = .default
        
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: isDaily)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
        notificationCenter.add(request)

        
        
        //save model
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(uId)
            .collection("todos")
            .document(newId)
            .setData(newItem.asDictionary())
        
    }
    
    
    func saveNoDate(){
        guard canSave else {
            return
        }
        
        //get user id
        guard let uId = Auth.auth().currentUser?.uid else{
            return
        }
        
        //create model
        let newId = UUID().uuidString
        let newItem = ToDoListItem(id: newId,
                                   title: title,
                                   dueDate: 0,
                                   createdDate: Date().timeIntervalSince1970,
                                   isDone: false)
        
        
        //save model
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(uId)
            .collection("todos")
            .document(newId)
            .setData(newItem.asDictionary())
        
    }
    
    var canSave: Bool{
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else{
            return false
        }
        
        guard dueDate >= Date().addingTimeInterval(-86400) || dueDate == Date(timeIntervalSince1970: 0) else{
            return false
        }
        
        return true
    }
}
