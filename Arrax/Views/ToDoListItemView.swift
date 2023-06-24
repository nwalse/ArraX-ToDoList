//
//  ToDoListItemView.swift
//  Arrax
//
//  Created by Neel Walse on 5/23/23.
//

import SwiftUI
import UIKit

struct ToDoListItemView: View {
    @StateObject var viewModel = ToDoListItemViewVM()
    let item: ToDoListItem
    let gradient = Gradient(colors: [Color("GradL"), Color("GradD")])
    
    var body: some View {
        ZStack{
            Rectangle()
            .foregroundColor(.clear)
            .frame(width: 370, height: 77)
            .background(Color("ListModules"))
            .cornerRadius(20)
            
            
            HStack{
                Button {
                    //withAnimation(.easeOut(duration: 1.0)) {
                    viewModel.toggleIsDone(item: item)
                    //}
                    
                } label: {
                    Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(Color.blue)
                        .font(Font.system(size: 22))
                        .padding(.leading, 7)
                        .overlay {
                            LinearGradient(gradient: gradient, startPoint: .init(x: 0, y: 0), endPoint: .init(x: 1, y: 1))
                                .mask(
                                    Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                                        .foregroundColor(Color.blue)
                                        .font(Font.system(size: 22))
                                        .padding(.leading, 7)
                                )
                        }
                }
                
                
                VStack(alignment: .leading){
                    Text(item.title)
                        .font(
                            Font.custom("Inter", size: 18)
                            .weight(.regular)
                            )
                        .foregroundColor(Color("Text"))
                    Text("\(Date(timeIntervalSince1970: item.dueDate).formatted(date: .abbreviated, time: .shortened))")
                        .font(
                            Font.custom("Inter", size: 12)
                            .weight(.medium)
                            )
                        .foregroundColor(Color("Text"))
                        .opacity(0.70)
                }
                .padding(.leading, 8)
                
                Spacer()
                
                
                
            }
            .opacity(item.isDone ? 0.4 : 1.0)
            .animation(.easeInOut(duration: 0.7), value: item.isDone)
            .padding(.leading,40)
        }
        .padding(.bottom, -5)
        .padding(.top, -5)
        .transition(.slide)
    }
}

struct ToDoListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListItemView(item: .init(id: "333",
                                     title: "dfdf",
                                     dueDate: Date().timeIntervalSince1970,
                                     createdDate: Date().timeIntervalSince1970,
                                     isDone: false))
    }
}





