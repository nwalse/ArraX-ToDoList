//
//  ContentView.swift
//  Arrax
//
//  Created by Neel Walse on 5/23/23.
//
import FirebaseFirestoreSwift
import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewVM()
    //@AppStorage("isDarkMode") private var isDark = false
    
    var body: some View {
        
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
            //signed in
            //ZStack{

                
                //TabView {
                    ToDoListView(userId: viewModel.currentUserId)
                        //.environment(\.colorScheme, isDark ? .dark : .light)
                        //.tabItem {
                        //    Label("Home", systemImage: "house")
                        //}
                    
                    //ProfileView()
                        //.tabItem {
                        //    Label("Profile", systemImage: "person.circle")
                        //}
                //}
                
                
                

            //}
        } else {
            LoginView()
                //.environment(\.colorScheme, isDark ? .dark : .light)
        }
        

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
