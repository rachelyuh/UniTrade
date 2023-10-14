//
//  SignUpView.swift
//  SwiftUIStarterKitApp
//
//  Created by Osama Naeem on 03/08/2019.
//  Copyright © 2019 NexThings. All rights reserved.
//

import SwiftUI

struct SignUpView: View {
    
    @State var emailAddress: String = ""
    @State var name: String = ""
    @State var phone: String = ""
    @State var password: String = ""
    @State var bio: String = ""
    @State var pronouns: String = ""
    @State var filledVar: String = ""
    @State var username: String = ""
    @State var confirmPassword: String = ""
    
    var body: some View {
        
        GeometryReader { geometry in
            VStack (alignment: .center){
                HStack (alignment: .center){
                    Spacer()
                }
                
                Text("Create an Account")
                    .font(.title)
                    .font(.system(size: 14, weight: .bold, design: Font.Design.default))
                    .padding(.bottom, 10)
                
                Button(action: {
                    print("Add photo")
                }) {
                    VStack(alignment: .center) {
                        Text("+")
                            .font(.system(size: 18))
                        Text("Add Photo (Required)")
                            .font(.system(size: 10))
                    }.padding()
                        .frame(width: 100, height: 100)
                        .foregroundColor(Color.white)
                        .background(Color.blue)
                }
                .clipShape(Circle())
                .padding(.bottom, 10)
                
                VStack {
                    TextField("Name (Required)", text: self.$name)
                        .frame(width: geometry.size.width - 45, height: 40)
                        .textContentType(.emailAddress)
                        .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0))
                        .accentColor(.red)
                        .background(Color(red: 242 / 255, green: 242 / 255, blue: 242 / 255))
                        .cornerRadius(5)
                    
                    TextField("Username (Required)", text: self.$username)
                        .frame(width: geometry.size.width - 45, height: 40)
                        .textContentType(.emailAddress)
                        .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0))
                        .accentColor(.red)
                        .background(Color(red: 242 / 255, green: 242 / 255, blue: 242 / 255))
                        .cornerRadius(5)
                    
                    TextField("Pronouns", text: self.$pronouns)
                        .frame(width: geometry.size.width - 45, height: 40)
                        .textContentType(.emailAddress)
                        .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0))
                        .accentColor(.red)
                        .background(Color(red: 242 / 255, green: 242 / 255, blue: 242 / 255))
                        .cornerRadius(5)
                    
                    TextField("Email (Required)", text: self.$emailAddress)
                        .frame(width: geometry.size.width - 45, height: 40)
                        .textContentType(.emailAddress)
                        .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0))
                        .accentColor(.red)
                        .background(Color(red: 242 / 255, green: 242 / 255, blue: 242 / 255))
                        .cornerRadius(5)
                    
                    TextField("Phone", text: self.$phone)
                        .frame(width: geometry.size.width - 45, height: 40)
                        .textContentType(.emailAddress)
                        .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0))
                        .accentColor(.red)
                        .background(Color(red: 242 / 255, green: 242 / 255, blue: 242 / 255))
                        .cornerRadius(5)
                    
                    TextField("Password (Required)", text: self.$password)
                        .frame(width: geometry.size.width - 45, height: 40)
                        .textContentType(.emailAddress)
                        .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0))
                        .accentColor(.red)
                        .background(Color(red: 242 / 255, green: 242 / 255, blue: 242 / 255))
                        .cornerRadius(5)
                    TextField("Confirm Password (Required)", text: self.$confirmPassword)
                        .frame(width: geometry.size.width - 45, height: 40)
                        .textContentType(.emailAddress)
                        .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0))
                        .accentColor(.red)
                        .background(Color(red: 242 / 255, green: 242 / 255, blue: 242 / 255))
                        .cornerRadius(5)
                    
                    
                    
                    VStack(alignment: .leading) {
                        Text("bio: (Required)")
                            .font(.headline)
                            .foregroundColor(.black)
                        ZStack {
                            RoundedRectangle(cornerRadius: 10) // You can use any shape here
                                .frame(width: 350, height: 100)
                                .foregroundColor(Color.gray.opacity(0.3))
                            
                            TextEditor(text: $bio)
                                .frame(width: 340, height: 90)
                                .padding(5)
                        }
                        
                    }
                    
                    Text("Terms of Service and Privacy Policy")
                        .foregroundColor(Color.blue)
                        .padding(.bottom, 10)
                        .font(.system(size: 12))
                    
                    Text(filledVar)
                        .foregroundColor(.red)
                        .font(.system(size: 12))
                    
                    }
                
                @StateObject
                var viewModel = WriteData()
                
                VStack{
                    Button(action: {
                        let filled = !name.isEmpty && !emailAddress.isEmpty && emailAddress.contains("@gatech.edu") && !password.isEmpty && !bio.isEmpty && !username.isEmpty && !confirmPassword.isEmpty
                        
                        if filled {
                            filledVar = ""
                            viewModel.pushNewUser(username: username, name: name, pfp: "fakepfp", bio: bio, password: password, email: emailAddress, productList: [1,4], serviceList: [2,3])
                        }
                        if !filled {
                            filledVar = "Not all required fields are filled!"
                        }
                           }) {
                        HStack {
                            Text("Create Account")
                        }
                        .padding()
                        .frame(width: geometry.size.width - 40, height: 40)
                        .foregroundColor(Color.white)
                        .background(Color.blue)
                        .cornerRadius(5)
                    }.padding(.bottom, 40)
                                    
                }
            }
        }
        
    }
    
    struct Previews_SignUpView_Previews: PreviewProvider {
        static var previews: some View {
            SignUpView()
        }
    }
}



struct Previews_SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
