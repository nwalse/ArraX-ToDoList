//
//  ProfileView.swift
//  Arrax
//
//  Created by Neel Walse on 5/23/23.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var viewModel = ProfileViewVM()
    let gradient = Gradient(colors: [Color("GradL"), Color("GradD")])
    
    var body: some View {
        NavigationView {
            VStack {
                Rectangle()
                .foregroundColor(.clear)
                .frame(width: 370, height: 6)
                .background(Color("Module"))
                .cornerRadius(30)
                
                ZStack{
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 370, height: 78)
                        .background(Color("Module"))
                        .cornerRadius(20)
                    
                    Text("Profile")
                        .font(Font.custom("Inter-SemiBold", size: 25))
                        .foregroundColor(Color("Text"))
                        .padding(.leading, -170)
                }
                .padding(.bottom, 1)
                if let user = viewModel.user {
                    
                    //avatar
                    ZStack{
                        Rectangle()
                          .foregroundColor(.clear)
                          .frame(width: 370, height: 380)
                          .background(Color("Module"))
                          .cornerRadius(20)
                          
                            
                        
                        
                        //info
                        VStack(alignment: .leading) {
                            
                            Image(systemName: "person.crop.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .foregroundColor(Color("Text"))
                                .frame(width: 38, height: 38)
                                .overlay {
                                    LinearGradient(gradient: gradient, startPoint: .init(x: 0, y: 0), endPoint: .init(x: 1, y: 1))
                                        .mask(
                                            Image(systemName: "person.crop.circle")
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .foregroundColor(Color("Text"))
                                                .frame(width: 38, height: 38)
                                        )
                                }
                            
                            HStack{
                                Text("Name: ")
                                    .font(Font.custom("Inter-SemiBold", size: 16)
                                        
                                    )
                                    .foregroundColor(Color("Text"))
                                Text(user.name)
                                    .font(
                                    Font.custom("Inter", size: 16)
                                    .weight(.medium)
                                    )
                                    .foregroundColor(Color("Text"))
                            }
                            .padding(.leading, -16)
                            .padding()
                            .padding(.bottom, -20)
                            
                            HStack{
                                Text("Email: ")
                                    .font(Font.custom("Inter-SemiBold", size: 16)
                                        .weight(.bold)
                                    )
                                    .foregroundColor(Color("Text"))
                                
                                Text(user.email)
                                    .font(Font.custom("Inter", size: 16)
                                        .weight(.medium)
                                    )
                                    .foregroundColor(Color("Text"))
                            }
                            .padding(.leading, -16)
                            .padding()
                            .padding(.bottom, -10)
                            
                            Text("Member Since: ")
                                .font(Font.custom("Inter-SemiBold", size: 16)
                                    .weight(.bold)
                                )
                                .foregroundColor(Color("Text"))
                            
                            Text("\(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .shortened))")
                                .font(Font.custom("Inter", size: 16)
                                    .weight(.medium)
                                )
                                .foregroundColor(Color("Text"))
                            
                            
                            Button {
                                viewModel.logout()
                            } label: {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(.clear)
                                        .frame(width: 280, height: 35)
                                        .background(Color("Module"))
                                        .cornerRadius(10)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 16)
                                                .stroke(Color("LogoutRed"), lineWidth: 2)
                                        )
                                    Text("Logout")
                                        .foregroundColor(Color("LogoutRed"))
                                        .font(Font.custom("Inter-Medium", size: 16))
                                }
                            }
                            .padding(.top, 30)
                        }
                        .padding()
                        
                        //sign out
            
                        
                    }
                    Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 370, height: 6)
                    .background(Color("Module"))
                    .cornerRadius(30)
                    .padding(.top, 2)
                    
                    Spacer()
                }else {
                    Text("Loading Profile...")
                }
                
                
            }
            
        }
        .onAppear {
            viewModel.fetch()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
