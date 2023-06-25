//
//  LoginView.swift
//  Arrax
//
//  Created by Neel Walse on 5/23/23.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel = LoginViewVM()
    @State private var ani = true
    let gradient = Gradient(colors: [Color("GradL"), Color("GradD")])
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                //Header
                
                ZStack {
                    
                    
                    VStack{
                        Image("ArraX")
                            .resizable()
                            .scaledToFit()
                            .padding(.top, 30)
                        Text("Workflow organized in an Array.")
                            .padding(.top, -70)
                            .font(.custom("Inter-Medium", size: 18))
                            .foregroundColor(Color("Text"))
                        
                    }
                    .padding(.top, 30)
                    
                    
                }
                .frame(width: UIScreen.main.bounds.width * 3, height: 300)
                .offset(y: -100)
                
                
                
                ZStack {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 340, height: 228)
                        .background(Color("Module"))
                        .cornerRadius(20)
                    
                    
                    if !viewModel.error.isEmpty {
                        Text(viewModel.error)
                            .foregroundColor(Color("LogoutRed"))
                            .padding(.bottom, 190)
                            .font(Font.custom("Inter-Medium", size: 14))
                        
                    }
                    VStack{
                        TextField("Email Address", text: $viewModel.email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.none)
                            .font(Font.custom("Inter", size:16))
                            //.foregroundColor(.clear)
                            .frame(width: 300, height: 35)
                            .background(Color("Module"))
                            .cornerRadius(10)
                        
                        SecureField("Password", text: $viewModel.password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.none)
                            .autocorrectionDisabled()
                            .font(Font.custom("Inter", size: 16))
                            //.foregroundColor(.clear)
                            .frame(width: 300, height: 35)
                            .background(Color("Module"))
                            .cornerRadius(10)
                        
                        Button{
                            viewModel.login()
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(.clear)
                                    .frame(width: 280, height: 35)
                                    .background(Color("Module"))
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            //.stroke(.blue, lineWidth: 2)
                                            .stroke(LinearGradient(gradient: gradient, startPoint: .init(x: 0, y:0), endPoint: .init(x: 1, y:1)), lineWidth: 2)
                                    )
                                Text("Login")
                                    //.foregroundColor(Color.blue)
                                    .font(Font.custom("Inter-Medium", size: 16))
                                    .overlay{
                                        LinearGradient(gradient: gradient, startPoint: .init(x: 0, y:0), endPoint: .init(x: 1, y:1))
                                            .mask(
                                                Text("Login")
                                                    //.foregroundColor(Color.blue)
                                                    .font(Font.custom("Inter-Medium", size: 16))
                                            )
                                    }
                                    
                                    
                            }
                        }
                        .padding(.top, 40)
                        
                    }
                }
                .padding(.top, -110)
                
                
                //Create Account
                ZStack{
                    Rectangle()
                      .foregroundColor(.clear)
                      .frame(width: 340, height: 115)
                      .background(Color("Module"))
                      .cornerRadius(20)
                    
                    VStack{
                        Text("Don't have an Account?")
                            .font(.custom("Inter-Medium", size: 16))
                            .foregroundColor(Color("Text"))
                        
                        
                        NavigationLink(destination: RegisterView()){
                            ZStack{
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 278, height: 34)
                                    .background(Color("Module"))
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(.gray, lineWidth: 2)
                                    )
                                Text("Sign Up")
                                    .foregroundColor(.gray)
                                    .font(Font.custom("Inter-Medium", size: 16))
                                    .frame(width: 278, height: 34)
                            }
                        }
                        .padding(.top, 10)
                        
                    }
                    
                    
                    
                }
                .padding(.bottom, 50)
                .padding(.top, 160)
            }
            
            
            
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
