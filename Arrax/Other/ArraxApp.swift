//
//  ArraxApp.swift
//  Arrax
//
//  Created by Neel Walse on 5/23/23.
//

import SwiftUI
import FirebaseCore
import UserNotifications

@main
struct ArraxApp: App {
    init() {
        FirebaseApp.configure()
        checkForPermission()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            
        }
    }
    
    func checkForPermission() {
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .authorized:
                self.dispatchNotification()
            case .denied:
                return
            case .notDetermined:
                notificationCenter.requestAuthorization(options: [.alert, .sound]) { didAllow, error in
                    if didAllow {
                        self.dispatchNotification()
                    }
                }
            default:
                return
            }
            
        }
    }
    
    func dispatchNotification() {
        
        let identifier = "hello"
        let title = "time"
        let body = "dfjhdhkjfhd"
        let hour = 14
        let minute = 35
        let isDaily = false
        
        let notificationCenter = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        let calendar = Calendar.current
        var dateComponents = DateComponents(calendar: calendar, timeZone: TimeZone.current)
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: isDaily)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
        notificationCenter.add(request)
         
    }
}








/*
import SwiftUI
import FirebaseCore

import UIKit
import UserNotifications

@main
struct ArraxApp: App {
    init() {
        FirebaseApp.configure()
        
        // Request permission to display notifications
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if granted {
                print("Notification permission granted")
            } else {
                print("Notification permission denied")
            }
        }
        
        // Set the UNUserNotificationCenter delegate
        UNUserNotificationCenter.current().delegate = UIApplication.shared.delegate as? AppDelegate
        
        // Register for remote notifications
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}




//@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Request permission to display notifications
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if granted {
                print("Notification permission granted")
            } else {
                print("Notification permission denied")
            }
        }
        
        // Set the UNUserNotificationCenter delegate
        UNUserNotificationCenter.current().delegate = self
        
        // Register for remote notifications
        application.registerForRemoteNotifications()
        
        return true
    }
    
    // Method called when the app successfully registers for remote notifications
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Convert device token to string
        let tokenString = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        
        // Send the device token to your server for further processing
        print("Device Token: \(tokenString)")
    }
    
    // Method called when the app fails to register for remote notifications
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for remote notifications: \(error.localizedDescription)")
    }
    
    // Method called when a notification is received while the app is running or in the background
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Customize the notification's appearance (e.g., show an alert, play a sound, modify badge count)
        // You can also handle custom actions based on the notification's category identifier
        
        // For example, to show an alert and play a sound for the received notification:
        completionHandler([.banner, .sound])
    }
    
    // Method called when a user interacts with a notification (e.g., taps on it)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // Handle the user's action (e.g., open a specific view or perform a task)
        // You can identify the action using response.actionIdentifier or the notification's category identifier
        
        // For example, to open a specific view when the notification is tapped:
        if response.actionIdentifier == UNNotificationDefaultActionIdentifier {
            // Open a specific view or perform a task
        }
        
        completionHandler()
    }
}
*/






/*
import SwiftUI
import FirebaseCore
import UIKit
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        // Request permission to display notifications
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if granted {
                print("Notification permission granted")
            } else {
                print("Notification permission denied")
            }
        }
        
        // Set the UNUserNotificationCenter delegate
        UNUserNotificationCenter.current().delegate = self
        
        // Register for remote notifications
        UIApplication.shared.registerForRemoteNotifications()
        
        return true
    }
    
    // Method called when the app successfully registers for remote notifications
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Convert device token to string
        let tokenString = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        
        // Send the device token to your server for further processing
        print("Device Token: \(tokenString)")
    }
    
    // Method called when the app fails to register for remote notifications
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for remote notifications: \(error.localizedDescription)")
    }
    
    // Method called when a notification is received while the app is running or in the background
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Customize the notification's appearance (e.g., show a banner, play a sound, modify badge count)
        // You can also handle custom actions based on the notification's category identifier
        
        // For example, to show a banner and play a sound for the received notification:
        completionHandler([.banner, .sound])
    }
    
    // Method called when a user interacts with a notification (e.g., taps on it)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // Handle the user's action (e.g., open a specific view or perform a task)
        // You can identify the action using response.actionIdentifier or the notification's category identifier
        
        // For example, to open a specific view when the notification is tapped:
        if response.actionIdentifier == UNNotificationDefaultActionIdentifier {
            // Open a specific view or perform a task
        }
        
        completionHandler()
    }
}

@main
struct ArraxApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
*/
