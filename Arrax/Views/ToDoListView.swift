//
//  TodoListItemsView.swift
//  Arrax
//
//  Created by Neel Walse on 5/23/23.
//

import FirebaseFirestoreSwift
import SwiftUI
import UIKit
import UniformTypeIdentifiers

struct ToDoListView: View {
    
    @StateObject var viewModel: ToDoListViewVM
    @FirestoreQuery var items: [ToDoListItem]
    @AppStorage("isDarkMode") private var isDark = false
    @State private var ani = true
    let gradient = Gradient(colors: [Color("GradL"), Color("GradD")])
    
    @StateObject var viewModel2 = NewItemViewVM()
    
    @State private var newTitle = ""
    //@State var draggedItem : ToDoListItem
    //@StateObject var viewModel2 = NewItemViewVM()
    
    //private let userId: String
    
    init(userId: String){
        //self.userId = userId
        self._items = FirestoreQuery(collectionPath: "users/\(userId)/todos")
        self._viewModel = StateObject(wrappedValue: ToDoListViewVM(userId: userId))
    }
    
    var body: some View {
        VStack{
            
            Image("Trans")
                .resizable()
                .frame(width: 120, height: 35)
                .padding(.top, 30)
                .padding(.leading, -180)
            
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 370, height: 6)
                .background(Color("Module"))
                .cornerRadius(30)
            
            
            NavigationView {
                GeometryReader { geometry in
                    VStack {
                        ZStack{
                            
                            
                            ScrollView {
                                LazyVStack(spacing: 15){
                                    
                                    //List(items) { item in
                                    ForEach(items) { item in
                                        ToDoListItemView(item: item)
                                            .transition(.slide)
                                            .swipeActions {
                                                Button("Delete") {
                                                    viewModel.delete(id: item.id)
                                                }
                                                .tint(Color("LogoutRed"))
                                                
                                            }
                                        
                                        
                                    }
                                    .listStyle(.plain)
                                    .transition(.slide)
                                    
                                    
                                    HStack{
                                        Spacer()
                                        VStack{
                                            Spacer()
                                            Rectangle()
                                                .foregroundColor(.clear)
                                                .frame(width: 370, height: 6)
                                                .background(Color("Module"))
                                                .cornerRadius(30)
                                            TextField("+ New Task", text: $viewModel2.title)
                                                .font(Font.custom("Inter-Medium", size: 19))
                                                .padding()
                                                .background(Color("Module"))
                                                .frame(width: 370)
                                                .cornerRadius(20)
                                                .onSubmit {
                                                    performButtonAction()
                                                }
                                            Spacer()
                                        }
                                        Spacer()
                                    }
                                    
                                    
                                    
                                }
                                .animation(.easeInOut(duration: 0.7), value: ani)
                                .transition(.slide)
                                .listStyle(.plain)
                                
                            }
                            //.frame(height: 600)
                            .frame(height: geometry.size.height * 0.79)
                            .animation(.easeInOut(duration: 0.7), value: ani)
                            .transition(.slide)
                            .padding(.bottom, geometry.size.height * 0.19)
                            
                            ZStack{
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 370, height: 78)
                                    .background(Color("Module"))
                                    .cornerRadius(20)
                                Spacer()
                                Text("Home - To Do")
                                    .font(Font.custom("Inter-SemiBold", size: 25))
                                    .foregroundColor(Color("Text"))
                                    .padding(.leading, -150)
                            }
                            //.padding(.top, 30)
                            //.padding(.bottom, 690)
                            .padding(.bottom, geometry.size.height * 1.1)
                            
                            
                            
                            ZStack{
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 370, height: 81)
                                    .background(Color("Module"))
                                    .cornerRadius(20)
                                    .padding(.top, 90)
                                Button{
                                    //Action
                                    viewModel.showingNewItemView = true
                                } label: {
                                    Image("Plus")
                                        .resizable()
                                        .frame(width: 90, height: 80)
                                        .padding(.top, 30)
                                    
                                }
                                
                                HStack{
                                    Button {
                                        isDark.toggle()
                                    } label: {
                                        if isDark {
                                            Label("", systemImage: "cloud.sun")
                                                .font(.system(size: 30))
                                                .overlay {
                                                    LinearGradient(gradient: gradient, startPoint: .init(x: 0, y: 0), endPoint: .init(x: 1, y: 1))
                                                        .mask(
                                                            Label("", systemImage: "cloud.sun")
                                                                .font(.system(size: 30))
                                                        )
                                                }
                                        } else {
                                            Label("", systemImage: "cloud.moon")
                                                .font(.system(size: 30))
                                                .overlay {
                                                    LinearGradient(gradient: gradient, startPoint: .init(x: 0, y: 0), endPoint: .init(x: 1, y: 1))
                                                        .mask(
                                                            Label("", systemImage: "cloud.moon")
                                                                .font(.system(size: 30))
                                                        )
                                                }
                                        }
                                    }
                                    .padding(.top, 90)
                                    .padding(.leading, 50)
                                    
                                    Spacer()
                                    
                                    NavigationLink(destination: ProfileView()) {
                                        Image(systemName: "person.fill")
                                            .padding(.top, 90)
                                            .padding(.trailing, 50)
                                            .font(.system(size: 30))
                                            .font(.system(size: 30))
                                            .overlay {
                                                LinearGradient(gradient: gradient, startPoint: .init(x: 0, y: 0), endPoint: .init(x: 1, y: 1))
                                                    .mask(
                                                        Image(systemName: "person.fill")
                                                            .padding(.top, 90)
                                                            .padding(.trailing, 50)
                                                            .font(.system(size: 30))
                                                    )
                                            }
                                        
                                    }
                                }
                                
                            }
                            //.padding(.top, 600)
                            .padding(.top, geometry.size.height * 0.6)
                            
                            
                        }
                    }
                    //.frame(width: geometry.size.width, height: geometry.size.height)
                    //.padding(.vertical, -80)
                    
                }
                
            }
            .sheet(isPresented: $viewModel.showingNewItemView){
                NewItemView(newItemPresented: $viewModel.showingNewItemView)}
            
            
        }
        .background(Color("Background"))
        .environment(\.colorScheme, isDark ? .dark : .light)
        .animation(.easeInOut(duration: 0.4), value: isDark)
        
        
    }
    
    func performButtonAction() {
        viewModel2.saveNoDate()
        viewModel2.title = ""
    }
     
}

/*
struct MyDropDelegate : DropDelegate {
    let item : String
    @Binding var items : [String]
    @Binding var draggedItem : String?
    func performDrop(info: DropInfo) -> Bool {
        return true
    }
    func dropEntered(info: DropInfo) {
        guard let draggedItem = self.draggedItem else {
            return
        }
        if draggedItem != item {
            let from = items.firstIndex(of: draggedItem)!
            let to = items.firstIndex(of: item)!
            withAnimation(.default) {
                self.items.move(fromOffsets: IndexSet(integer: from), toOffset: to > from ? to + 1 : to)
            }
        }
    }
}
*/
struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView(userId: "h0F4ZY9mmUR1ZEfIVclGasQmh2J3")
    }
}



/*
 .toolbar {
 
 Button{
 //Action
 viewModel.showingNewItemView = true
 } label: {
 Image(systemName: "plus")
 }
 
 }
 .toolbar {
 ToolbarItem(placement: .navigationBarTrailing) {
 EditButton()
 }
 }
 */
