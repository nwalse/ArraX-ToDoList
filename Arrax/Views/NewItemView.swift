//
//  NewItemView.swift
//  Arrax
//
//  Created by Neel Walse on 5/23/23.
//

import SwiftUI

struct NewItemView: View {
    
    @StateObject var viewModel = NewItemViewVM()
    @Binding var newItemPresented: Bool
    @State private var toggleD = true
    @AppStorage("isDarkMode") private var isDark = false
    let gradient = Gradient(colors: [Color("GradL"), Color("GradD")])
    //@State private var toggleT = true
    
    var body: some View {
        
        
        VStack {
            
            Rectangle()
                .fill(Color("ListModules"))
                .frame(height: 6)
                .frame(width: 200)
                .padding(.vertical, 15)
                .cornerRadius(5000)
            
            Text("New Item")
                .padding(.top, 20)
                .font(
                    Font.custom("Inter", size: 33)
                    .weight(.semibold)
                    )
                .foregroundColor(Color("Text"))
                .padding(.leading, -10)
            /*
            Rectangle()
                .fill(Color.gray)
                .frame(height: 4)
                .frame(width: 360)
                .padding(.vertical, 10)
                .cornerRadius(34)
            */
            Form {
                
                Section {
                    //title
                    TextField("Title", text: $viewModel.title)
                        .font(Font.custom("Inter-Medium", size: 19))
                }
                
                Section {
                    
                    
                    Toggle("Date and Time", isOn: $toggleD)
                        .padding(.top, 10)
                        .opacity(0.80)
                        .font(Font.custom("Inter-Medium", size: 17))
                    //Toggle("Time", isOn: $toggleT)
                    
                    
                    //due date
                    if toggleD {
                        DatePicker("Due Date", selection: $viewModel.dueDate)
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .opacity(toggleD ? 1: 0)
                    }
                    
                    //button
                    HStack{
                        Spacer()
                        Button {
                            if viewModel.canSave {
                                if toggleD{
                                    viewModel.save()
                                }else{
                                    viewModel.saveNoDate()
                                }
                                newItemPresented = false
                            } else {
                                viewModel.showAlert = true
                            }
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(.clear)
                                    .frame(width: 280, height: 35)
                                    .background(Color("Button"))
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(LinearGradient(gradient: gradient, startPoint: .init(x: 0, y:0), endPoint: .init(x: 1, y:1)), lineWidth: 2)
                                    )
                                Text("Save")
                                    .foregroundColor(Color.blue)
                                
                                    .font(Font.custom("Inter-Medium", size: 16))
                                    .overlay{
                                        LinearGradient(gradient: gradient, startPoint: .init(x: 0, y:0), endPoint: .init(x: 1, y:1))
                                            .mask(
                                                Text("Save")
                                                //.foregroundColor(Color.blue)
                                                
                                                    .font(Font.custom("Inter-Medium", size: 16))
                                            )
                                    }
                            }
                            
                        }
                        .padding()
                        Spacer()
                    }
                    
                    //.padding(.leading, 17)
                    
                    
                }
                
            }
            .animation(.easeInOut, value: toggleD)
            .alert(isPresented: $viewModel.showAlert){
                Alert(title: Text("Error"), message: Text("Please fill in all fields and select a present or future date"))
                    
                    
            
            }
            
            
            
        }
        .background(Color("Background").edgesIgnoringSafeArea(.all))
        .environment(\.colorScheme, isDark ? .dark : .light)
        
    }
    
}

struct NewItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewItemView(newItemPresented: Binding(get: {return true}, set: { _ in}))
    }
}



