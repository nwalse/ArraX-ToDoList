//
//  RegisterView.swift
//  Arrax
//
//  Created by Neel Walse on 5/23/23.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewVM()
    let gradient = Gradient(colors: [Color("GradL"), Color("GradD")])
    
    var body: some View {
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
                        .font(Font.custom("Inter-Medium", size: 18))
                        .foregroundColor(Color("Text"))
                    
                }
                .padding(.top, 30)
                
                
            }
            .frame(width: UIScreen.main.bounds.width * 3, height: 300)
            .offset(y: -100)
            
            
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 340, height: 270)
                    .background(Color("Module"))
                    .cornerRadius(20)
                
                
                //Login
                VStack{
                    if !viewModel.error.isEmpty {
                        Text(viewModel.error)
                            .foregroundColor(Color("LogoutRed"))
                            .font(Font.custom("Inter-Medium", size: 14))
                            .padding(.bottom, 0)
                        
                    }
                    
                    TextField("Name", text: $viewModel.name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocorrectionDisabled()
                        .font(Font.custom("Inter", size: 16))
                        //.foregroundColor(.clear)
                        .frame(width: 300, height: 35)
                        .background(Color("Module"))
                        .cornerRadius(10)
                    TextField("Email", text: $viewModel.email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                        .font(Font.custom("Inter", size: 16))
                        //.foregroundColor(.clear)
                        .frame(width: 300, height: 35)
                        .background(Color("Module"))
                        .cornerRadius(10)
                    SecureField("Password", text: $viewModel.password)
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(Font.custom("Inter", size: 16))
                        //.foregroundColor(.clear)
                        .frame(width: 300, height: 35)
                        .background(Color("Module"))
                        .cornerRadius(10)
                    
                    Button{
                        viewModel.register()
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.clear)
                                .frame(width: 280, height: 35)
                                .background(Color("Module"))
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(LinearGradient(gradient: gradient, startPoint: .init(x: 0, y:0), endPoint: .init(x: 1, y:1)), lineWidth: 2)
                                )
                            Text("Sign Up")
                                .foregroundColor(Color.blue)
                                
                                .font(Font.custom("Inter-Medium", size: 16))
                                .overlay{
                                    LinearGradient(gradient: gradient, startPoint: .init(x: 0, y:0), endPoint: .init(x: 1, y:1))
                                        .mask(
                                            Text("Sign Up")
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
            
            
            Spacer()
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
